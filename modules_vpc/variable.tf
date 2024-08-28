variable "main_region" {
 type = string
 default = "us-east-1" 
}

variable "ssh_key_private" {
  type    = string
  #Replace this with the location of you private key
  default = "./loginkey"
}

variable "ssh_key_public" {
  type    = string
  #Replace this with the location of you public key .pub
  default = "./loginkey.pub"
}

