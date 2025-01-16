resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.demovpc.id
  route {
    cidr_block = aws_vpc.demovpc.cidr_block
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "publicrt"
  }
}
resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.demovpc.id
  route {
    cidr_block = aws_vpc.demovpc.cidr_block
    gateway_id = "local"
  }
  tags = {
    Name = "privatert"
  }
}
resource "aws_route_table_association" "rtsubnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.publicrt.id
}
resource "aws_route_table_association" "rtsubnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.privatert.id
}