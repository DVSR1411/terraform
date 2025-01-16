resource "aws_instance" "myinstance" {
  ami                    = "ami-04a37924ffe27da53"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key.id
  vpc_security_group_ids = [aws_security_group.mysg.id]
  tags = {
    Name        = var.name
    description = "My ec2 instance"
  }
  user_data = var.user_data
}
output "public_ip" {
  value = aws_instance.myinstance.public_ip
}