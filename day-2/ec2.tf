provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
    ami = var.image_id
    instance_type = var.instance_type
    key_name = var.key_pair
    vpc_security_group_ids = [var.sg_id, aws_security_group.my_sg.id]
    tags = {
        Name = "my_instance"
        env = "dev"
    }


    user_data = <<EOF
    #!/bin/bash
    yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    EOF
}

resource "aws_security_group" "my_sg" {
    name = "my_sg"
    description = "new security group"
    vpc_id = data.aws_vpc.my_vpc.id

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port =80
        to_port =80
        protocol = "tcp"
    }

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
    }

      ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }

      egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
        protocol = -1
    }
}

data "aws_vpc" "my_vpc" {
    default = true
}

variable "image_id" {
    default = "ami-07a00cf47dbbc844c"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "key_pair" {
    default = "global"
}

variable "sg_id" {
    default = "sg-082cd8b58e65bbb0a"
}

output "public_ip" {
    value = aws_instance.my_instance.public_ip
}