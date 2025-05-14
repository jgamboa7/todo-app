resource "aws_ecs_cluster" "todo-app-cluster" {
  name = "todo-app-cluster"

  tags = {
    name = "todo-app"
  }
}

resource "aws_ecs_task_definition" "todo-app-task" {
  family                   = "todo-app-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name      = "todo-app-container"
      image     = var.todo-app-uri
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])

  tags = {
    name = "todo-app"
  }
}

resource "aws_ecs_service" "todo-app-service" {
  name            = "todo-app-service"
  cluster         = aws_ecs_cluster.todo-app-cluster.id
  task_definition = aws_ecs_task_definition.todo-app-task.arn
  desired_count   = 1
  launch_type     = "FARGATE" 

  network_configuration {
    subnets         = var.subnet_id
    security_groups = var.security_group_id
    assign_public_ip = true
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
