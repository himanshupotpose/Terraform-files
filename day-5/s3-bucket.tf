terraform {                           
    backend "s3" {       // terraform state file ko aws s3 me store karne ke liye backend configuration define karta hai. [backend = state file store kar ne ki jagah].
      region = "ap-south-1"       // terraform ko batata hai ki s3 bucket kis aws region me ban ne vale hai.                  
      bucket = "Himanshu-2026"  // this is s3 bucket name jisme terraform state file store hogi.
      key = "terraform.tfstate"  // this is the name of the terraform state file / and path define kar ta hai jisme terraform state file store hogi.
    }
}
provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
    ami = "ami-07a00cf47dbbc844c"
    instance_type = "t3.small"
    key_name = "npm"
    vpc_security_group_ids = ["sg-07316d011e1dec8ce"]
    tags = {
        Name = "my_instance"
        env = "dev"
    }
}