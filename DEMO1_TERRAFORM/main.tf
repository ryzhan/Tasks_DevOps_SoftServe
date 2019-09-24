provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

resource "google_compute_network" "my_network" {
  name = "my-net"
  auto_create_subnetworks = "true"
 # depends_on = ["google_compute_network.my_network"]
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "ssh-firewall"
  network = var.network

  depends_on = ["google_compute_network.my_network"]

  target_tags = ["mongo"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_instance" "mongo-db-tf" {
  name         = "mongo-db-tf"
  machine_type = var.machine_type
  zone = var.zone

  tags = ["mongo"]

  depends_on = ["google_compute_firewall.allow-ssh"]

  metadata = {
   ssh-keys = "erkek:${file(var.public_key_path)}"
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
    user = "erkek"
    host = "${google_compute_instance.mongo-db-tf.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = true   
  } 
  provisioner "file" {
    source      = "./modules/mongo-db-tf/scenario_mongo.sh"
    destination = "~/scenario_mongo.sh"

  }

  provisioner "remote-exec" {
    inline = [
      #"export MONGO_NETWORK_IP=${var.network_ip}",
      "chmod +x ~/scenario_mongo.sh",
      "sudo ~/scenario_mongo.sh ${google_compute_instance.mongo-db-tf.network_interface.0.network_ip}",
    ]
  
  }
}

