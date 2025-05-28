resource "google_compute_network" "vpc_network" {
  for_each = var.vpcs

  name                    = each.value.name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  for_each = var.vpcs

  name          = each.value.subnet_name
  ip_cidr_range = each.value.subnet_cidr
  region        = each.value.region
  network       = google_compute_network.vpc_network[each.key].self_link
}