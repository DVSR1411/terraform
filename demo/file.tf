resource "local_file" "demo" {
  filename        = "Hello.txt"
  content         = "Hi ${random_pet.mypet.id} how do you do?"
  file_permission = "0700"
  # 0700 is the permission for read, write and execute for owner only
  # 0777 is for read, write and execute for all users
  depends_on = [
    random_pet.mypet
  ]
}
resource "random_pet" "mypet" {
  prefix    = "Mr"
  separator = "."
  length    = 1
}