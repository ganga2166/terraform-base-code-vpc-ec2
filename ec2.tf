# ec2 instances

# data "aws_ami" "myami" {
  
# most_recent = true

# owners = ["397850908274"]

# }


resource "aws_instance" "green_server" {
  
count = "${var.env == "dev" ? 3 : 1}"

ami = "${lookup(var.amis,var.region)}"
# ami = "ami-0b0dcb5067f052a63"

# count = 3


#count = "${"var.env" == "dev" ? 3 : 1}"

#availability_zone = "us-east-1a"
subnet_id = "${element(aws_subnet.public_subnets.*.id,count.index)}"
#security_groups = "${aws_security_group.allow-all.tags.Name}"

vpc_security_group_ids = ["${aws_security_group.allow-all.id}"]

key_name = "laptop"

instance_type = "${var.vm-type}"

associate_public_ip_address = true

 tags = {

    Name = "green-server-${count.index}"
    Env = "${var.env}"
    

 }


}