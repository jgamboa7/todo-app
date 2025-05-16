provider "aws" {
  region = "eu-central-1"
}

resource "aws_dynamodb_table" "terraform-lock-table-todo-app" {
  name           = "terraform-lock-table-todo-app"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Project = "todo-app"
  }
}
