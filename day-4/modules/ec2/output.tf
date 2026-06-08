output public_ip {                            // The output.tf file is used to define the terraform's outputs.
  value       = aws_instance.appserver.public_ip  // Terraform will extract the public P of the appserver instance and show it in the output.
}







// The work of ouput.tf is to display some important values on the terminal after the resource is created.