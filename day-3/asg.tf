resource "aws_autoscaling_group" "home_asg" {
    name = "${var.project}-${var.env}-home-asg"     // dynamic ASG name .
    availability_zones = ["ap-south-1a", "ap-south-1b"]  // ASG will be created in 2 availability zones for high availability.
    desired_capacity = 1
    max_size = 2
    min_size = 1
    launch_template {              // the Launch template will be used to launch ASG instances .
        id = aws_launch_template.home_launch_template.id
        version = "$Latest"       // launch template version will be latest for ASG instances.
    }

}

// This is home auto scaling policy.  they decide scale up and scale down of ASG instances .
resource "aws_autoscaling_policy" "home_asg_policy" {
  name                   = "${var.project}-${var.env}-home-asg-policy"
  autoscaling_group_name = aws_autoscaling_group.home_asg.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60
  }
}

// Mobile ASG .
resource "aws_autoscaling_group" "mobile_asg" {
    name = "${var.project}-${var.env}-mobile-asg"
    availability_zones = ["ap-south-1a", "ap-south-1b"]
    desired_capacity = 1
    max_size = 2
    min_size = 1
    launch_template {
        id = aws_launch_template.mobile_launch_template.id
        version = "$Latest"
    }

}

// Mobile Auto scaling policy .
resource "aws_autoscaling_policy" "mobile_asg_policy" {
  name                   = "${var.project}-${var.env}-mobile-asg-policy"
  autoscaling_group_name = aws_autoscaling_group.mobile_asg.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60
  }
}

// Laptop ASG .
resource "aws_autoscaling_group" "laptop_asg" {
    name = "${var.project}-${var.env}-laptop-asg"
    availability_zones = ["ap-south-1a", "ap-south-1b"]
    desired_capacity = 1
    max_size = 2
    min_size = 1
    launch_template {
        id = aws_launch_template.laptop_launch_template.id
        version = "$Latest"
    }

}

// Laptop Auto scaling policy .
resource "aws_autoscaling_policy" "laptop_asg_policy" {
  name                   = "${var.project}-${var.env}-laptop-asg-policy"
  autoscaling_group_name = aws_autoscaling_group.laptop_asg.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60
  }
}

// home target group attachment to ASG
resource "aws_autoscaling_attachment" "home_tg_attachment" {
    autoscaling_group_name = aws_autoscaling_group.home_asg.name
    lb_target_group_arn = aws_lb_target_group.home_target_group.arn    
}

// laptop target group attachment to ASG
resource "aws_autoscaling_attachment" "laptop_tg_attachment" {
    autoscaling_group_name = aws_autoscaling_group.laptop_asg.name
    lb_target_group_arn = aws_lb_target_group.laptop_target_group.arn
    depends_on = [
        aws_autoscaling_attachment.home_tg_attachment
    ]
}

//mobile target group attachment to ASG
resource "aws_autoscaling_attachment" "mobile_tg_attachment" {
    autoscaling_group_name = aws_autoscaling_group.mobile_asg.name
    lb_target_group_arn = aws_lb_target_group.mobile_target_group.arn
    depends_on = [
        aws_autoscaling_attachment.laptop_tg_attachment
    ]
}