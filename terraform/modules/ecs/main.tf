
resource "aws_ecs_cluster" "threat_app_cluster" {
  name = "threat-app-cluster"
 #checkov requirement
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "threat-app-td"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  #task_role_arn       = var.task_role_arn
  execution_role_arn  = var.execution_role_arn
  cpu                     = 1024
  memory                  = 2048

  container_definitions = jsonencode([
    {
      name                 = "threat-app-1"
      image                = var.container_image
      cpu                  = 512
      memory               = 1536
      memoryReservation    = 1024
      essential            = true

      environment = [
      {
        name  = "PORT"
        value = "3000"
      },
      {
      name  = "DB_PORT"
      value = "3306"  # MySQL port
  }

    ]


      portMappings = [
        {
          name           = "container-port"
          containerPort  = 3000
          hostPort      = 3000
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]


    logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/threat-app-service"
          "awslogs-region"        = "eu-west-2"
          "awslogs-stream-prefix" = "container"
        }
      }



secrets = [
  {
    name      = "DB_USERNAME"
    valueFrom = "${var.db_secret_arn}:username::"
  },
  {
    name      = "DB_PASSWORD"
    valueFrom = "${var.db_secret_arn}:password::"
  },
  {
    name      = "DB_NAME"
    valueFrom = "${var.db_secret_arn}:dbname::"
  },
  {
    name      = "DB_HOST"
    valueFrom = "${var.db_secret_arn}:host::"
  }

]
    }
  ])

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }




}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name = "/ecs/threat-app-service"
  retention_in_days = 14
}


resource "aws_ecs_task_definition" "db_seeder" {
  family                   = "user-portal-db-seeder"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "db-seeder",
      image     = var.seeder_container,
      essential = true,

      secrets = [
        {
          name      = "DB_USERNAME"
          valueFrom = "${var.db_secret_arn}:username::"
        },
        {
          name      = "DB_PASSWORD"
          valueFrom = "${var.db_secret_arn}:password::"
        },
        {
          name      = "DB_NAME"
          valueFrom = "${var.db_secret_arn}:dbname::"
        },
        {
          name      = "DB_HOST"
          valueFrom = "${var.db_secret_arn}:host::"
        }
      ],

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "/ecs/db-seeder-task",
          "awslogs-region"        = "eu-west-2",
          "awslogs-stream-prefix" = "db-seeder"
        }
      }
    }
  ])

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}

# ECS Service
resource "aws_ecs_service" "this" {
  name            = "threat-app-service"
  cluster         = aws_ecs_cluster.threat_app_cluster.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
   assign_public_ip = true
    subnets         = var.subnet_ids
    security_groups = [var.security_group_id]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "threat-app-1"
    container_port   = 3000
  }

  deployment_controller {
    type = "ECS"
  }


depends_on = [var.http_listener_arn, var.https_listener_arn]


}
