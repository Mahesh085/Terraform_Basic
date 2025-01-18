resource "aws_vpc" "myvpc" {
    tags = {
        Name = var.vpc_name
    }
        cidr_block = var.vpc_cidr_block
        instance_tenancy = "default"
        enable_dns_hostnames = "true"
}
resource "aws_subnet" "Public_subnet" {
    tags = {
        Name = var.Public_Subnet_name[count.index]
    }
    vpc_id = aws_vpc.myvpc.id
    count = 2
    availability_zone = var.Public_subnet_AZ[count.index]
    cidr_block = var.Public_SN_cidr_block[count.index]
    map_public_ip_on_launch = "true"
}
resource "aws_subnet" "Private_subnet" {
    tags = {
        Name = var.Private_Subnet_name[count.index]
    }
    vpc_id = aws_vpc.myvpc.id
    count = 2
    availability_zone = var.Private_subnet_AZ[count.index]
    cidr_block = var.Private_SN_cidr_block[count.index]
}
resource "aws_internet_gateway" "myigw" {
    tags = {
        Name = var.IGW_name
    }
    vpc_id = aws_vpc.myvpc.id
}
resource "aws_route_table" "Public-RT" {
    tags = {
        Name = var.Public_route_table_name
    }
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myigw.id

    }
}
resource "aws_eip" "eip" {
    domain = "vpc"
}
resource "aws_nat_gateway" "mynat" {
    tags = {
        Name = var.Nat_Name
    }
    subnet_id = aws_subnet.Public_subnet[0].id
    connectivity_type = "public" 
    allocation_id = aws_eip.eip.id
}

resource "aws_route_table" "Private-RT" {
    tags = {
        Name = var.Private_route_table_name
    }
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.mynat.id

    }
}
resource "aws_route_table_association" "route_public_ass" {
    count = 2
    subnet_id = aws_subnet.Public_subnet[count.index].id
    route_table_id = aws_route_table.Public-RT.id
}
resource "aws_route_table_association" "route_private_ass" {
    count = 2
    subnet_id = aws_subnet.Private_subnet[count.index].id
    route_table_id = aws_route_table.Private-RT.id
}
output "aws_vpc_id" {
    value = aws_vpc.myvpc.id

}
output "subnet_Subnet_id_1" {
  value = aws_subnet.Public_subnet[0].id
}
output "subnet_Subnet_id_2" {
  value = aws_subnet.Public_subnet[1].id
}
