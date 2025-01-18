variable "vpc_name" {
    type = string
}
variable "vpc_cidr_block" {
    type = string
}

variable "Public_Subnet_name" {
    type = list(string)
}
variable "Public_subnet_AZ" {
    type = list(string)
}
variable "Public_SN_cidr_block" {
    type = list(string)
}
variable "Private_Subnet_name" {
    type = list(string)
}
variable "Private_subnet_AZ" {
    type = list(string)
}
variable "Private_SN_cidr_block" {
    type = list(string)
}
variable "IGW_name" {
    type = string
}
variable "Public_route_table_name" {
    type = string
}
variable "Nat_Name" {
    type = string
}
variable "Private_route_table_name" {
    type = string
}