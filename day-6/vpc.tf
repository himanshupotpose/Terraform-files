provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "vpc" {}

resource "aws_subnet" "subnet" {
    vpc_id = "${aws_vpc.vpc.id}"
    map_public_ip_on_launch  = true
    tags = {
        Name = "my_subnet"
        env = "dev"
    }
}