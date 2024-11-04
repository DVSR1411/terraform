# EC2 Instance
resource "aws_instance" "myec2vm" {
  ami                    = data.aws_ami.my-ami.id
  instance_type          = var.instance_type
  user_data              = file("${path.module}/test.sh")
  key_name               = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.demo-ssh.id, aws_security_group.demo-web.id]
  tags = {
    "Name" = "EC2 Test"
  }
}