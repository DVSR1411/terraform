resource "aws_instance" "myinstance" {
  ami                    = "ami-04a37924ffe27da53"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key.id
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id = aws_subnet.subnet1.id
  associate_public_ip_address = true
  tags = {
    Name        = "demo"
    description = "My ec2 instance"
  }
}
output "public_ip" {
  value = aws_instance.myinstance.public_ip
}