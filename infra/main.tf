module "ecr" {
  source            = "./modules/ecr"
}

module "ecs" {
  source            = "./modules/ecs"
  todo-app-uri      = var.todo-app-uri
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
}