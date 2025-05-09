resource "aws_dynamodb_table" "mydb" {
  name         = "test"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "name"
  attribute {
    name = "name"
    type = "S"
  }
}
resource "aws_dynamodb_table_item" "item" {
  table_name = aws_dynamodb_table.mydb.name
  hash_key   = aws_dynamodb_table.mydb.hash_key
  item       = <<EOF
        {
            "name": {"S": "Hulk"},
            "email": {"S": "hulk@avengers.com"},
            "message": {"S": "Hulk smash"}
        }
    EOF
}