resource "aws_s3_bucket" "todo-app-terraform-state" {
  bucket = "todo-app-jg-tf-state"

    tags = {
        Name        = "todo-app-tf-state"
    }
}

resource "aws_s3_bucket_versioning" "todo_app_versioning" {
  bucket = aws_s3_bucket.todo-app-terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}