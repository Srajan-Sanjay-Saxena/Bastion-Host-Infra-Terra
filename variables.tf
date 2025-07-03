variable "vpc_cidr_block" {
  type = string
}

variable "mumbai_subnets" {
  type = list(object({
    availability_zone = string
    is_public         = bool
  }))
}