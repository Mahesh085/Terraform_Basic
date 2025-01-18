variable "asg_name" {
  type        = string
}
variable "minimum_size" {
  type        = number
}
variable "maximum_size" {
  type        = number
}
variable "desired_capacity" {
  type        = number
}
variable "load_balancers" {
  type        = list(string)
}
variable "vpc_zone_identifier" {
  type        = list(string)
}
variable "tempalte_id" {
  type        = string
}
