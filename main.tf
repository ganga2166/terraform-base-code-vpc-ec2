#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}


# creating vpc

resource "aws_vpc" "green" {
  cidr_block = "${var.cidr_block}"
  enable_dns_hostnames = true

  tags = {
    Name = "green_vpc"
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.green.id}"

  tags = {
    Name = "${var.aws_internet_gateway}"
  }
}

# subnets

resource "aws_subnet" "subnet-1" {
  vpc_id = "${aws_vpc.green.id}"
  cidr_block = "${var.public_subnet-1}"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "public_subnet_1"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id = "${aws_vpc.green.id}"
  cidr_block = "${var.public_subnet-2}"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "public_subnet_2"
  }
}

# route table

resource "aws_route_table" "terraform-public" {
  vpc_id = "${aws_vpc.green.id}"
  
  route  {
    cidr_block = "0.0.0.0/16"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }  

    tags = {
    Name = "${var.route-name}"
  }
  
}

# route association

resource "aws_route_table_association" "terraform-associate-route" {
  subnet_id = "${aws_subnet.subnet-1.id}"
  route_table_id = "${aws_route_table.terraform-public.id}"

}

# security groups

resource "aws_security_group" "allow-all" {
  name = "allow-all"
  description = "Allow all inbound rules"
  vpc_id = "${aws_vpc.green.id}"

ingress {
  from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

egress {
  from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
}

tags = {

Name = "${var.security-grp-name}"

}


}




