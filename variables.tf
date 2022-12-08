variable "access_key" {}
variable "secret_key" {}
variable "cidr_block" {}
variable "aws_internet_gateway" {}
# variable "public_subnet-1" {}
# variable "public_subnet-2" {}
variable "route-name" {}
variable "security-grp-name" {}
variable "vm-type" {}

variable "public-subnets" {
 type = list
 default = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]

}

variable "azs" {
 type = list
 default = ["us-east-1a","us-east-1b","us-east-1c"]

}


variable "private-subnets" {
  
  type = list
  default = ["10.0.40.0/24","10.0.50.0/24","10.0.60.0/24"]


}


variable "privateroute-name" {}