resource "aws_db_instance" "db" {
#   identifier           = "3tier-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  allocated_storage    = 20
#   name                 = "mydb"
  username             = "admin"
  password             = "changeme1234"
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = var.db_subnet_ids
}
