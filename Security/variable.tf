variable "SG_name" {
    type = string
}
variable "sg_name" {
    type = string
}
variable "SG_description" {
    type = string
}
variable "ports" {
    type = list(any)
}
variable "sg_cidr_block" {
    type = list(string)
}
variable "vpc_idd" {
    type = string
}