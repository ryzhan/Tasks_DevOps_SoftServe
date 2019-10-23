

resource "google_compute_firewall" "allow-ssh" {
  name    = "ssh-firewall"
  network = var.network

  #depends_on = ["google_compute_network.my_network"]

  target_tags = ["server-db","app-server","jenkins-8080-tf"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "server-db" {
  name    = "server-db"
  network = var.network
  
  #depends_on = ["google_compute_network.my_network"]

  target_tags = ["server-db"]

  allow {
    protocol = "tcp"
    ports    = ["27017","3306","27000"]
  }
  
  #source_ranges = ["output.network_ip_production"]

}

resource "google_compute_firewall" "app-server" {
  name    = "app-server"
  network = var.network

  #depends_on = ["google_compute_network.my_network"]

  target_tags = ["app-server"]

  allow {
    protocol = "tcp"
    ports    = ["8081","8080","8082"]
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