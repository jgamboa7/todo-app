resource "aws_ecr_repository" "todo-app-registry" {
  name                 = "todo-app"

  image_scanning_configuration {
    scan_on_push = true
  }
  
  tags = {
    name = "todo-app"
  }

}