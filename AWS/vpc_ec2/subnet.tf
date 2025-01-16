resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.demovpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "publicsubnet1"
  }
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.demovpc.id
  cidr_block = "10.0.16.0/20"
  tags = {
    Name = "privatesubnet1"
  }
  availability_zone = "ap-south-1b"
}