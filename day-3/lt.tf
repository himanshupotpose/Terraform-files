provider "aws" {             // provider tells terraform to use AWS to create the resources.
    region = "ap-south-1"    // All resources will be created in this region.
}

resource "aws_launch_template" "home_launch_template"{      // resource block to create home launch template.
    image_id = var.image_id                                 // AMI ID for the EC2 instance, which is passed as a variable.
    instance_type = var.instance_type                       // Instance type for the EC2 instance, which is passed as a variable.
    # launch_template_name = "${var.project}-home-lt"
    name = "${var.project}-${var.env}-home-lt"              // Name of the launch template to created dynamically.
    key_name = var.key_name                                // Key pair name for SSH access to the EC2 instance, which is passed as a variable.
    tags = {                                               // Tags to identify the launch template.
        env = var.env                                      // Environment tag, which is passed as a variable.
    }
    vpc_security_group_ids = [aws_security_group.security_group.id]   // Security group ID for the EC2 instance.
    user_data = base64encode(<<-EOF                                   // User data script to be executed when the EC2 instance is launched. It installs Apache2 and creates a simple HTML page.
    #!/bin/bash                                                       // This script tells to linux the script is executed to the bash shell.
    apt update -y                                                     // Update the package lists.
    apt install apache2 -y                                            // Install Apache2 web server.
    systemctl enable apache2                                          // Enable Apache2 to start on boot.
    systemctl start apache2                                           // Start the Apache2 service.
    echo "<h1> HELLO WORLD </h1>" > /var/www/html/index.html          // Create a simple HTML page with "HELLO WORLD" message.
    EOF                                                               // End of the user data script.
    )
}



resource "aws_launch_template" "laptop_launch_template"{  
    image_id = var.image_id
    instance_type = var.instance_type
    name = "${var.project}-${var.env}-laptop-lt"
    key_name = var.key_name
    tags = {
        env = var.env
    }
    vpc_security_group_ids = [aws_security_group.security_group.id]
    user_data = base64encode(<<-EOF
    #!/bin/bash
    apt update -y
    apt install apache2 -y
    systemctl enable apache2
    systemctl start apache2
    mkdir /var/www/html/laptop                                 
    echo "<h1> SALE SALE SALE in Laptop </h1>" > /var/www/html/laptop/index.html
    EOF
    )
}

resource "aws_launch_template" "mobile_launch_template"{
    image_id = var.image_id
    instance_type = var.instance_type
    name = "${var.project}-${var.env}-mobile-lt"
    key_name = var.key_name
    tags = {
        env = var.env
    }
    vpc_security_group_ids = [aws_security_group.security_group.id]
    user_data = base64encode(<<-EOF
    #!/bin/bash
    apt update -y
    apt install apache2 -y
    systemctl enable apache2
    systemctl start apache2 
    mkdir /var/www/html/mobile
    echo "<h1> This is mobile page </h1>" > /var/www/html/mobile/index.html
    EOF
    )
}