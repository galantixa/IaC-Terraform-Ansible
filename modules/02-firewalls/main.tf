resource "google_compute_firewall" "ssh_allow" {
  name    = "allow-ssh"
  network = var.network_self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  target_tags   = ["ssh-allowed"]
}