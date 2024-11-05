module "nexus" {
  source = "../modules"
  instance_type = "t2.medium"
  name = "nexus"
  user_data = file("nexus.sh")
}