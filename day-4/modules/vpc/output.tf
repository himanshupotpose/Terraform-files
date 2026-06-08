output vpc_id {                     // yeh output.tf file terraform ke outputs define karta hai.
  value       = aws_vpc.vpc.id
}

output pri_subnet_id {                // private subnet ki ID ko output kar raha hai.
  value       = aws_subnet.private.id
}

output pub_subnet_id {                // public subnet ki ID ko output kar raha hai.
  value       = aws_subnet.public.id
}   