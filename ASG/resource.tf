resource "aws_autoscaling_group" "myasg" {
    name = var.asg_name
    min_size = var.minimum_size
    max_size = var.maximum_size
    desired_capacity = var.desired_capacity
    health_check_type = "EC2"
    load_balancers = var.load_balancers
    vpc_zone_identifier = var.vpc_zone_identifier
    launch_template {
    id      = var.tempalte_id
  }
}