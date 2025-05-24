resource "random_string" "rds_password" {
  length  = 10
  upper   = true
  lower   = true
  numeric = true
  special = false
}
resource "aws_db_instance" "mysql" {
  identifier                 = "mysql-database-1"
  engine                     = "mysql"
  engine_version             = "8.0.41"
  instance_class             = "db.t4g.micro"
  allocated_storage          = 20
  max_allocated_storage      = 1000
  storage_type               = "gp2"
  db_name                    = "mydb"
  username                   = "admin"
  password                   = random_string.rds_password.result
  publicly_accessible        = true
  vpc_security_group_ids     = [aws_security_group.rds_sg.id]
  skip_final_snapshot        = true
  deletion_protection        = false
  auto_minor_version_upgrade = true
  multi_az                   = false
  storage_encrypted          = true
  depends_on                 = [random_string.rds_password]
  tags = {
    Name = "Free Tier MySQL"
  }
}
output "db_connection" {
  value = aws_db_instance.mysql.endpoint
}
output "db_password" {
  value = random_string.rds_password.result
}