
# Yeh output.tf file terraform ke outputs define karti hai
output "lb_endpoint" {
    value = aws_lb.application_load_balancer.dns_name
}