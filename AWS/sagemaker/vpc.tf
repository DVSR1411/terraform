data "aws_vpc" "myvpc" {}
data "aws_subnets" "mysubnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.myvpc.id]
  }
}
resource "random_integer" "index" {
  min = 0
  max = length(data.aws_subnets.mysubnets.ids) - 1
  keepers = {
    timestamp = timestamp()
  }
}
locals {
  random_subnet_id = element(data.aws_subnets.mysubnets.ids, random_integer.index.result)
}