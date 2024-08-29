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

variable "rules" {
  default = [
    {
      port = 80
      protocol = "tcp"
      cidrs = ["0.0.0.0/0"]
    },
    {
      port = 443
      protocol = "tcp"
      cidrs = ["0.0.0.0/0"]
    },
    {
      port = 8080
      protocol = "tcp"
      cidrs = ["0.0.0.0/0"]
    }
  ]
  
}