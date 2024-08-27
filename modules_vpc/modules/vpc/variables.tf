variable "region" {
    type = string
    default = "us-east-1"
}

# hard coding the cidr block
variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

# hard coding the cidr block 
variable "subnet_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"
}
