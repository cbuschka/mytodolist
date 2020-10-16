resource "aws_lambda_function" "lambda" {
  filename = var.archive
  function_name = "${var.scope}${var.name}"
  source_code_hash = filebase64sha256(var.archive)
  role = var.role
  handler = var.handler
  runtime = var.runtime
  memory_size = 3008
  environment {
    variables = {
      SCOPE = var.scope
      VERSION = var.build_version
    }
  }
}