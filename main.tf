terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.37.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  credentials = file(var.credential)
}

# VPC Network
module "vpc" {
  source = "./modules/01-vpc"
  vpcs   = var.vpcs
}

# Firewall Rules
module "firewalls" {
  source            = "./modules/02-firewalls"
  network_self_link = module.vpc.vpc_self_links["main"]
}

# Compute VM instances
module "compute" {
  source    = "./modules/03-compute-engine"
  instances = {
    for k, v in var.instances :
    k => merge(v, {
        subnet_self_link = module.vpc.subnet_self_links["main"],
        static_ip = try(google_compute_address.static_ip[k].address, null)
    })
  }
  new_user = var.new_user
  depends_on = [module.vpc]
}

# Static address
resource "google_compute_address" "static_ip" {
  for_each = {
    for k, v in var.instances : k => v if v.assign_static_ip == true
  }

  name   = "${each.key}-static-ip"
  region = var.region
}



