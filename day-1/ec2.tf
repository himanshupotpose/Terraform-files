provider "aws" {
    region = "eu-north-1"  
}

resource "aws_instance" "my_instance"{
    ami = "ami-05d62b9bc5a6ca605"
    instance_type = "t3.micro"
    key_name = "global"
    vpc_security_group_ids = ["sg-089796f61e66ccb82"]
    tags = {
        Name = "my_instance"
        env = "dev"
    }
}