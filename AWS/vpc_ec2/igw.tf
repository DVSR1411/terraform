resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demovpc.id
  tags = {
    Name = "Myigw"
  }
}