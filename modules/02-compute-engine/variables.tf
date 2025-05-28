variable "instances" {
  type = map(object({
    name             = string
    machine_type     = string
    zone             = string
    image            = string
    startup_script   = string
    subnet_self_link = string 
    assign_static_ip = bool
  }))
}

variable "new_user" {
  type = object({
    username = string
    password = string
  })
  sensitive = true
}


