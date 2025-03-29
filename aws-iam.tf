resource "aws_iam_role" "gateway_role" {
  name = "gateway-role"
  assume_role_policy = file("./iam/roles/apigateway-lambda-role.tfpl") 
}

resource "aws_iam_policy" "lambda_authorization_executor_policy" {
  name        = "lambda_executor_policy"
  policy      = templatefile("./iam/policies/apigateway-lambda-policy.tfpl", {lambda_arn = data.aws_lambda_function.valida_credenciais.arn }) 
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.gateway_role.name
  policy_arn = aws_iam_policy.lambda_authorization_executor_policy.arn
}
