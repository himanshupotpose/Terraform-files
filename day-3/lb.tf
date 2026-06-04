resource "aws_lb_target_group" "home_target_group" {          // Creating a target group of AWS load balancer .
    name = "${var.project}-${var.env}-home-tg"                // Name of the target group .
    port = 80                                                 // Backend server 80 port  traffic received by load balancer .
    protocol = "HTTP"                                         // Protocol used by load balancer to route traffic to backend server .
    vpc_id = data.aws_vpc.default.id                          // VPC ID where target group will be created .
    health_check {                                            // Health check configuration for target group .
        enabled = true                                        // Enable health check for target group .
        path = "/"                                            // ALB/ endpoint will be hit for health check .
        port = "traffic-port"                                 // It will use the same port that is configured for application traffic.
        protocol = "HTTP"                                     // Health check will be done through HTTP protocol .
    }
}

resource "aws_lb_target_group" "mobile_target_group" {
    name = "${var.project}-${var.env}-mobile-tg"
    port = 80
    protocol = "HTTP"
    health_check {
        enabled = true
        path = "/mobile/"
        port = "traffic-port"
        protocol = "HTTP"       
    }
    vpc_id = data.aws_vpc.default.id
}

resource "aws_lb_target_group" "laptop_target_group" {
    name = "${var.project}-${var.env}-laptop-tg"
    port = 80
    protocol = "HTTP"
    health_check {
        enabled = true
        path = "/laptop/"
        port = "traffic-port"
        protocol = "HTTP"       
    }
    vpc_id = data.aws_vpc.default.id
}

data "aws_subnets" "my_subnets" {           // ye existing subnets ko AWS se fetch kar raha hai.
  filter {                                  // filtering condition start.
    name   = "vpc-id"                       // filter name.
    values = [data.aws_vpc.default.id]      // filter value, ye VPC ID ke basis pe subnets ko filter karega.
  }
}
resource "aws_lb" "application_load_balancer" {      // Creating an AWS Application Load Balancer (ALB) resource.
    name = "${var.project}-${var.env}-alb"           // Name of the load balancer.
    internal = false                                 // ALB ko internet facing banane ke liye internal ko false set karte hain.
    load_balancer_type = "application"               // Load balancer type set karte hain application load balancer ke liye.
    security_groups = [aws_security_group.security_group.id]   // ALB ke security group ko specify karte hain.
    subnets = data.aws_subnets.my_subnets.ids                  // ALB kin subnets me deploy hoga, ye subnets ke IDs specify karte hain.
}

resource "aws_lb_listener" "application_load_balancer_listener" {    // Creating a listener for the ALB.
    load_balancer_arn = aws_lb.application_load_balancer.arn         // ALB ke ARN ko specify karte hain jiske liye listener create karna hai.
    port = 80                                                        // HTTP traffic port 80 par receive karega.
    protocol = "HTTP"                                                // Protocol HTTP set karte hain.
    default_action {                                                 // Default action specify karte hain jab koi specific rule match nahi karta.
        type = "forward"                                             // traffic ko forward karne ke liye action type set karte hain.
        target_group_arn = aws_lb_target_group.home_target_group.arn // Default traffic home target group par forward hoga.
    }
}

resource "aws_lb_listener_rule" "laptop_listener_rule" {              // Creating a listener rule for routing traffic to laptop target group.
    listener_arn = aws_lb_listener.application_load_balancer_listener.arn  // Listener ARN specify karte hain jiske liye rule create karna hai.
    priority = 101                                                    // rule evaluation priority. smaller number = higher priority.
    action {                                                          // Action specify karte hain jab rule match karta hai.
        type             = "forward"                                 // traffic ko forward karne ke liye action type set karte hain.
        target_group_arn = aws_lb_target_group.laptop_target_group.arn  // traffic laptop target group par forward hoga.
    }

  condition {                                 // condition specify karta hain rule kab trigger hoga.
    path_pattern {                            // path pattern URL path check karta hain.
      values = ["/laptop/*"]                  // agar URL path /laptop/ se start hota hai to ye rule match karega aur traffic laptop target group par forward hoga.
    }
  }
}

resource "aws_lb_listener_rule" "mobile_listener_rule" {                   // Creating a listener rule for routing traffic to mobile target group.
    listener_arn = aws_lb_listener.application_load_balancer_listener.arn  // Listener ARN specify karte hain jiske liye rule create karna hai.
    priority = 100                                                    // rule evaluation priority. smaller number = higher priority.
    action {                                                          // Action specify karte hain jab rule match karta hai.
        type             = "forward"                                 // traffic ko forward karne ke liye action type set karte hain.
        target_group_arn = aws_lb_target_group.mobile_target_group.arn  // traffic mobile target group par forward hoga.
    }

  condition {                                // condition specify karta hain rule kab trigger hoga.
    path_pattern {                           // path pattern URL path check karta hain.
      values = ["/mobile/*"]                 // agar URL path /mobile/ se start hota hai to ye rule match karega aur traffic mobile target group par forward hoga.
    }
  }
}