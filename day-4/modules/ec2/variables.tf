// variables.tf file terraform mein input variables define karne ke liye use hoti hai.



variable "image_id" {
default     = "ami-07a00cf47dbbc844c"
}

variable "instance_type" {
default     = "t3.micro"
}

variable "key_name" {
    default = "npm"
}

variable "private_subnet_id" {}

variable "public_subnet_id" {}