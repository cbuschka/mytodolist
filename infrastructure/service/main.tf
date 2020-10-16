provider "aws" {
  region = var.aws_region
  version = "~> 3.11.0"
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "iam_role_for_lambda" {
  name = "${var.scope}iam_role_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment_basic" {
  role = aws_iam_role.iam_role_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment_custom" {
  role = aws_iam_role.iam_role_for_lambda.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

module "mytodolist_lambda_postlist" {
  source = "../modules/lambda"
  name = "mytodolist_lambda_postlist"
  handler = "com.github.cbuschka.mytodolist.lambda.post_list.PostListEntryPoint"
  runtime = "java11"
  archive = "../../lambda/target/lambda.jar"
  role = aws_iam_role.iam_role_for_lambda.arn
  scope = var.scope
  build_version = var.build_version
}

resource "aws_api_gateway_rest_api" "mytodolist_api" {
  name = "${var.scope}MyTodoList API"
  endpoint_configuration {
    types = [
      "EDGE"
    ]
  }
}

resource "aws_api_gateway_resource" "mytodolist_api_res_list" {
  rest_api_id = aws_api_gateway_rest_api.mytodolist_api.id
  parent_id = aws_api_gateway_rest_api.mytodolist_api.root_resource_id
  path_part = "list"
}

module "mytodolist_list_post" {
  source = "../modules/api_binding"
  rest_api_id = aws_api_gateway_rest_api.mytodolist_api.id
  resource_id = aws_api_gateway_resource.mytodolist_api_res_list.id
  method = "ANY"
  path = aws_api_gateway_resource.mytodolist_api_res_list.path
  lambda = module.mytodolist_lambda_postlist.name
  region = var.aws_region
  account_id = data.aws_caller_identity.current.account_id
  scope = var.scope
}

resource "aws_api_gateway_deployment" "mytodolist_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.mytodolist_api.id
  stage_name = "${var.scope}api"
  description = "Deploy methods: ${module.mytodolist_list_post.http_method}"
}