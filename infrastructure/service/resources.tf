data "aws_dynamodb_table" "lists_table" {
  name = "${var.scope}lists"
}