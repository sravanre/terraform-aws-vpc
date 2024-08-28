provider "aws" {
  region = var.main_region
}

module "vpc" {
    source = "./modules/vpc"
    region = var.main_region
}

resource "aws_instance" "my-instance1" {
    ami = module.vpc.ami_id
    subnet_id = module.vpc.subnet_id
    instance_type = "t3.micro"
    associate_public_ip_address = true
    security_groups = [module.vpc.securityGroup_id]
    key_name = aws_key_pair.this.key_name
    tags = {
      Name = "pub-ec2-1"
    }
  
}

#Create key-pair for logging into EC2 
#======================================
resource "aws_key_pair" "this" {
  key_name   = "login-key-pub-1"   ## this has to resemble with the name of the instance 
  public_key = file(var.ssh_key_public)
}