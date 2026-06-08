// yeh variables.tf file VPC aur subnet creation ke liye input variables define karti hai. isme sab variables ko default values di gye hai.

variable project {   // project variable project ka naam store karta hai.
default = "cbz"
}

variable vpc_cidr {   // VPC CIDR block VPC ka network range define karta hai.
default = "10.0.0.0/16"
}

variable private_subnet_cidr {    // private subnet CIDR  private subnet ka IP range define kar ta hai
default = "10.0.0.0/24"
}

variable public_subnet_cidr {     // public subnet CIDR public subnet ka IP range define karta hai.
default = "10.0.1.0/24"
}

variable private_az {       // private availability zone private subnet ko AWS mumbai region ke AZ-A mein create karega.
default = "ap-south-1a"
}

variable public_az {       // public availability zone public subnet ko AWS mumbai region ke AZ-B mein create karega.
default = "ap-south-1b"
}





// outside script 
// main.tf

//provider "aws" {
//    region = "ap-south-1"
//}

//module "my_vpc" {
//    source = "./modules/vpc"
//}

//module "my_ec2" {
//    source = "./modules/ec2"
//    private_subnet_id = module.my_vpc.pri_subnet_id
//    public_subnet_id = module.my_vpc.pub_subnet_id
//}
