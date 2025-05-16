module "ecr" {
  source            = "./modules/ecr"
}

module "ecs" {
  source                    = "./modules/ecs"
  todo-app-uri              = var.todo-app-uri
  private_subnet_id         = module.vpc.private_subnet_id
  security_group_id         = module.sg.allow_alb_sg_id
  todo_app_tg_arn           = module.alb.todo_app_tg_arn  
}

module "s3_tfstate" {
  source            = "./modules/s3_tfstate"
}

module "dynamodb-lock-table-todo-app" {
  source            = "./modules/dynamodb-lock-table-todo-app"
} 

module "vpc" {
  /* region  = var.aws_region */
  source           = "./modules/vpc"
}

module "sg" {
  source           = "./modules/sg"
  vpc_id           = module.vpc.vpc_id
  cidr_ipv4        = module.vpc.cidr_ipv4
}

module "alb" {
  source                = "./modules/alb"
  vpc_id                = module.vpc.vpc_id
  acm_certificate_arn   = var.acm_certificate_arn
  lb_sg_id              = module.sg.alb_sg_id
  public_subnet_id      = module.vpc.public_subnet_id
}