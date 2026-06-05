variable "image_id" {
default     = "ami-0b6c6ebed2801a5cb"
}

variable "instance_type" {
default     = "t2.micro"
}

variable "key_name" {
    default = "new-key"
}

variable "private_subnet_id" {}

variable "public_subnet_id" {}