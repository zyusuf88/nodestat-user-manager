
output "task_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}
output "lambda_exec_role_arn" {
  value = aws_iam_role.lambda_exec_role.arn
}
