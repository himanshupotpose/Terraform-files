provider "aws" {
    region = "ap-south-1"  
}

resource "aws_instance" "my_instance"{
    ami = "ami-07a00cf47dbbc844c"
    instance_type = "t3.micro"
    key_name = "global"
    vpc_security_group_ids = ["sg-082cd8b58e65bbb0a"]
    tags = {
        Name = "my_instance"
        env = "dev"
    }
}   