resource "aws_secretsmanager_secret" "jwt_lambda_secret" {
  name = "secret_jwt_string"
  # secret format must be: { "secret": "??"}
}