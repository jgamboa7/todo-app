resource "aws_ecr_repository" "todo-app" {
  name                 = "todo-app"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    name = "todo-app-ecr"
  }

}