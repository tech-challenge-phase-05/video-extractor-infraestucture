locals {
  openapi_file = templatefile("./openapi/apigateway.tftpl", {
      load_balancer = var.load_balancer
      cognito_arn = aws_cognito_user_pool.pool.arn, 
      iam_arn=aws_iam_role.gateway_role.arn 
    }
  )
}

resource "aws_api_gateway_rest_api" "apigateway_video_extractor" {
  body = local.openapi_file
  name = "apigatway-video-extractor"
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.apigatway_video_extractor.id

  triggers = {
    redeployment = sha1(local.openapi_file)
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.apigatway_video_extractor.id
  stage_name    = "prod"
}
