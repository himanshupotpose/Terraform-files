resource "aws_instance" "webserver" {   
    ami = var.image_id                             // which operating system ami id are used.  
    instance_type = var.instance_type              // EC2 instance type
    key_name = var.key_name                        // key pair is used for ssh login to the EC2 instance.
    subnet_id = var.private_subnet_id              // The instance launch in a private subnet.
}

resource "aws_instance" "appserver" {   
    ami = var.image_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.public_subnet_id              // The instance launch in a public subnet.
}


// var. is used to refer the variables in Terraform.