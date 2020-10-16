resource "aws_lambda_function" "lambda" {
  filename = var.archive
  function_name = "${var.scope}${var.name}"
  role = var.role
  handler = var.handler
  runtime = var.runtime
}