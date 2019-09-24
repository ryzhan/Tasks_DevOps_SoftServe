resource "google_compute_network" "my_network" {
  name = "my-net"
  auto_create_subnetworks = "true"
 # depends_on = ["google_compute_network.my_network"]
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "ssh-firewall"
  network = var.network

  depends_on = ["google_compute_network.my_network"]

  target_tags = ["mongo-tf","production-tf"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "mongo-db-tf" {
  name    = "mongo-tf"
  network = var.network
  
  depends_on = ["google_compute_network.my_network"]

  target_tags = ["mongo-tf"]

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  
  #source_ranges = ["module.production-tf.network_ip_production"]

}

resource "google_compute_firewall" "production-tf" {
  name    = "production-tf"
  network = var.network

  depends_on = ["google_compute_network.my_network"]

  target_tags = ["production-tf"]

  allow {
    protocol = "tcp"
    ports    = ["8081"]
  }
  
  #source_ranges = ["module."]

}