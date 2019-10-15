resource "google_compute_instance" "moodle" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone = var.zone
  tags = ["moodle", "http-server"]

  metadata = {
   ssh-keys = "${var.user_name}:${file(var.public_key_path)}"
  }

  metadata_startup_script = ""


  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  network_interface {
    network = var.network
    network_ip = var.network_ip
    access_config {
    }
  }

  connection {
    type = "ssh"
    user = "erkek"
    host = "${google_compute_instance.moodle.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = false   
  } 
  provisioner "file" {
    source      = "./modules/moodle/scenario_moodle_docker.sh"
    destination = "/tmp/scenario_moodle_docker.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/scenario_moodle_docker.sh",
      "sudo /tmp/scenario_moodle_docker.sh ${google_compute_instance.moodle.network_interface.0.access_config.0.nat_ip}",
    ]
  
  }
}
