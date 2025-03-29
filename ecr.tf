resource "aws_ecr_repository" "tech-challenge" {
  name                 = "tech-challenge-repo" 
  image_tag_mutability = "MUTABLE" 
  image_scanning_configuration {
    scan_on_push = true 
  }

  tags = {
    Environment = "dev"
    Project     = "tech-challenge"
  }
}
