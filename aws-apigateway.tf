locals {
  openapi_file = templatefile("./openapi/apigateway.tftpl", {
      load_balancer_order_payment = var.load_balancer_order_payment,
      load_balancer_order = var.load_balancer_order,
      load_balancer_product = var.load_balancer_product,
      cognito_arn = aws_cognito_user_pool.pool.arn, 
      lambda_uri= data.aws_lambda_function.valida_credenciais.invoke_arn, 
      iam_arn=aws_iam_role.gateway_role.arn 
    }
  )
}

data "aws_lambda_function" "valida_credenciais" {
  function_name = var.lambda_name
}

resource "aws_api_gateway_rest_api" "apigateway_lanchonete" {
  body = local.openapi_file
  name = "apigatway-lanchonete"
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.apigateway_lanchonete.id

  triggers = {
    redeployment = sha1(local.openapi_file)
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.apigateway_lanchonete.id
  stage_name    = "prod"
}
