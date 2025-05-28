output "firewall_rule_name" {
  value = google_compute_firewall.ssh_allow.name
}