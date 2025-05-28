# Global Variable

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "credential" {
  type = string
  default     = "/path/to/gcp-credentials.json"
}

variable "vpcs" {
  type = map(object({
    name         = string
    subnet_name  = string
    subnet_cidr  = string
    region       = string
  }))
}

variable "instances" {
  type = map(object({
    name             = string
    machine_type     = string
    zone             = string
    image            = string
    subnet_self_link = string
    startup_script   = string
    assign_static_ip = optional(bool)
  }))
}


variable "new_user" {
  type = object({
    username = string
    password = string
  })
  sensitive = true
}

