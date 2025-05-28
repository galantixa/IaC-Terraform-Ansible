resource "google_compute_instance" "vm_instance" {
  for_each = var.instances

  name         = each.value.name
  machine_type = each.value.machine_type
  zone         = each.value.zone

  tags = ["ssh-allowed"]

  boot_disk {
    initialize_params {
      image = each.value.image
    }
  }

  network_interface {
    subnetwork = each.value.subnet_self_link

    access_config {
      nat_ip = try(each.value.static_ip, null)
    }
  }

  metadata_startup_script = each.value.startup_script
  metadata = {
    startup-script = templatefile("${path.module}/startup.sh.tpl", {
      username = var.new_user.username
      password = var.new_user.password
    })
  }

}

