data "http" "myip" {
  url = "https://ifconfig.me/ip"
}
resource "aws_security_group" "rds_sg" {
  name        = "rds-public-access"
  description = "Allow public access to RDS MySQL"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.response_body}/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}