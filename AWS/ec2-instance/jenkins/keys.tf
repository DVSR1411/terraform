resource "aws_key_pair" "key" {
  public_key = file("key.pub")
}