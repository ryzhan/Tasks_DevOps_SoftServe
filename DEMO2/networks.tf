

resource "google_compute_firewall" "allow-ssh" {
  name    = "ssh-firewall"
  network = var.network

  #depends_on = ["google_compute_network.my_network"]

  target_tags = ["mongo-tf","production-tf","jenkins-8080-tf"]

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
  
  #depends_on = ["google_compute_network.my_network"]

  target_tags = ["mongo-tf"]

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  
  #source_ranges = ["output.network_ip_production"]

}

resource "google_compute_firewall" "production-tf" {
  name    = "production-tf"
  network = var.network

  #depends_on = ["google_compute_network.my_network"]

  target_tags = ["production-tf"]

  allow {
    protocol = "tcp"
    ports    = ["8081"]
  }
  
  #source_ranges = ["output.network_ip_production"]

}

resource "google_compute_firewall" "jenkins-8080-tf" {
  name    = "jenkins-8080-tf"
  network = var.network

  #depends_on = ["google_compute_network.my_network"]

  target_tags = ["jenkins-8080-tf"]

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  
  #source_ranges = ["output.network_ip_production"]

}