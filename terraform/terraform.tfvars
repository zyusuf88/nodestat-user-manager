project_name = "this-project"
domain_name  = "yzeynab.com"
record_name = "coder"
task_role_arn           = "arn:aws:iam::730335356758:role/this-project-ecs-execution-role"
execution_role_arn      = "arn:aws:iam::730335356758:role/ecs-task-execution-role"
ssm_parameter_access = "arn:aws:iam::730335356758:policy/ssm-parameter-access-policy"
container_image =   "730335356758.dkr.ecr.eu-west-2.amazonaws.com/coder-portal:latest"

db_username     = "youruser"
db_password     = "supersecurepassword"
db_name         = "myappdb"
db_secret_name  = "prod/mysql/this-projects-db-new"


#s3_bucket_name = "my-s3-bucket-678"
