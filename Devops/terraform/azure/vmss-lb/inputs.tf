variable "subnets_info" {
  type = list(object({
    name = string
    cidr = string
  }))
}
