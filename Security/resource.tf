resource "aws_security_group" "mysg" {
    tags = {
        Name = var.SG_name
    }
    vpc_id = var.vpc_idd
    name = var.sg_name
    description = var.SG_description
    dynamic "ingress" {
        for_each = var.ports
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = var.sg_cidr_block

        }
    }
    ingress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = var.sg_cidr_block

    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = var.sg_cidr_block

    }
}
output "SG_id" {
    value = aws_security_group.mysg.id

}