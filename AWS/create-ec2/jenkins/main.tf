module "jenkins" {
  source = "../modules"
  instance_type = "t2.micro"
  name = "jenkins"
  user_data = file("jenkins.sh")
}