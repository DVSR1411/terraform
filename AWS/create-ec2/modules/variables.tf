variable "instance_type" {
    type = string
    description = "Type of instance eg. t2.micro"
}
variable "user_data" {
    type = string
    description = "User data script"
}
variable "name" {
    type = string
    description = "Name of the instance"    
}