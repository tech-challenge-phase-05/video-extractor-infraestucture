resource "aws_iam_role" "gateway_role" {
  name = "gateway-role"
  assume_role_policy = file("./iam/roles/apigateway-lambda-role.tfpl") 
}
