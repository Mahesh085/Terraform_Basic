resource "aws_elb" "elb" {
    name = var.name_elb
    subnets = [var.sub_1,var.sub_2]
    security_groups = var.elb_security_group
    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_protocol = "http"
        lb_port = 80
    }
}
output "elb_name" {
    value = aws_elb.elb.name
}
