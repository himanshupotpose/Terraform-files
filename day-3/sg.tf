# This sg.tf file is creating a security group in AWS.
data "aws_vpc" "default" {             // Data blocks are used to read existing AWS resources.
    default = true                     // This data block is fetching the default VPC in the AWS account.
}


resource "aws_security_group" "security_group" {    // Resource block to create a security group in AWS.
    name = "${var.project}-${var.env}-sg"           // Name of the security group to be created dynamically using project and environment variables.
    description = "New Security Group"              // Description of the security group.
    vpc_id = data.aws_vpc.default.id                // VPC ID where the security group will be created.
    ingress {                                       // HTTP Inbound rule to allow traffic on port 80 from anywhere. ingress =incoming traffic.
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {                                      // SSH Inbound rule to allow traffic on port 22 from anywhere. ingress = incoming traffic.
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }           
    egress {                                      // Outbound rule to allow all traffic to anywhere. egress = outgoing traffic.
        from_port = 0
        to_port = 0
        protocol = "-1"                 // "-1" protocol means all protocols.  Ex: TCP, UDP, ICMP etc.
        cidr_blocks = ["0.0.0.0/0"]
    }
}