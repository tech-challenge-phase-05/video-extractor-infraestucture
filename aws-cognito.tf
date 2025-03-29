data "aws_region" "current" {}

locals {
  redirect_cognito_url = "http://localhost:8080" #Não pode ficar vazio
}

resource "aws_cognito_user_pool" "pool" {
  name = "user_pool"
  auto_verified_attributes = ["email"]
  password_policy {
    minimum_length = 6
    require_lowercase = true
    require_numbers = true
  }
  schema {
    attribute_data_type = "String"
    name = "cpf"
    mutable = true
    developer_only_attribute = false
    required = false
    string_attribute_constraints {
      min_length = 11
      max_length = 11
    }
  }
}

resource "aws_cognito_user" "admin" {
  username = "admin"
  user_pool_id = aws_cognito_user_pool.pool.id
  attributes = {
    cpf = "11111111111"
    email = "vinitsantanna@gmail.com"
    email_verified = true
  }
}

resource "aws_cognito_user_pool_client" "lanchonete" {
  name                  = "lanchonete"
  user_pool_id          = aws_cognito_user_pool.pool.id
  allowed_oauth_flows   = ["implicit"]
  allowed_oauth_scopes  = ["email", "openid", "phone"]
  allowed_oauth_flows_user_pool_client = true
  callback_urls =  [local.redirect_cognito_url] 
  default_redirect_uri = local.redirect_cognito_url
  supported_identity_providers         = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "domain_login_url" {
  domain       = lower(replace("${aws_cognito_user_pool.pool.id}", "_", "-"))
  user_pool_id = aws_cognito_user_pool.pool.id
}