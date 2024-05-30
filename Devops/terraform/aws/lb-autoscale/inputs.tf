variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "public_subnets_info" {
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}
variable "private_subnets_info" {
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}
# variable "ingress_rules_info" {
#   type = (object({
#     from_port        = number
#     to_port          = number
#     protocol         = string
#     description      = string
#     cidr_blocks      = list(string)
#     ipv6_cidr_blocks = list(string)
#   }))

# }
# variable "egress_rules_info" {
# #   type = object({
# #     from_port        = number
# #     to_port          = number
# #     protocol         = string
# #     description      = string
# #     cidr_blocks      = list(string)
# #     ipv6_cidr_blocks = list(string)
# #   })

# # }
