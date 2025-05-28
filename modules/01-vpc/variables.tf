variable "vpcs" {
  type = map(object({
    name         = string
    subnet_name  = string
    subnet_cidr  = string
    region       = string
  }))
}
