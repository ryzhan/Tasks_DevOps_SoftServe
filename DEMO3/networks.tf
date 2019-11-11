
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