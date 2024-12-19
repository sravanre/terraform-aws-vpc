resource "aws_db_instance" "db" {
#   identifier           = "3tier-db"
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 8
#   name                 = "mydb"
  username             = "admin"
  password             = "changeme1234"
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db.id]  ## security group for rds
  
}

resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = var.db_subnet_ids
}



resource "aws_security_group" "db" {
  name        = "db-tier-sg"
  description = "Security group for the Database Tier"
  vpc_id      = var.vpc_id

  # Allow inbound traffic from App Tier
  ingress {
    description      = "Allow MySQL traffic from App Tier"
    from_port        = 3306 # Change if using a different database
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [var.aws_security_group_app_id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

