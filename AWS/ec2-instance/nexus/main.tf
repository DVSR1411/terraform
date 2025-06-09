resource "aws_instance" "myinstance" {
  ami                    = "ami-04a37924ffe27da53"
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.key.id
  vpc_security_group_ids = [aws_security_group.mysg.id]
  tags = {
    Name        = "nexus"
    description = "My ec2 instance"
  }
  user_data = file("nexus.sh")
}
output "public_ip" {
  value = aws_instance.myinstance.public_ip
}