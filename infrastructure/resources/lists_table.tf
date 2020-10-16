resource "aws_dynamodb_table" "lists_table" {
  name = "${var.scope}lists"
  billing_mode = "PAY_PER_REQUEST"
  stream_enabled = false
  hash_key = "id"
  ttl {
    enabled = true
    attribute_name = "ttl"
  }
  attribute {
    name = "id"
    type = "S"
  }
}
