resource "aws_instance" "webserver" {   
    ami = var.image_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.private_subnet_id
}

resource "aws_instance" "appserver" {   
    ami = var.image_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.public_subnet_id
}