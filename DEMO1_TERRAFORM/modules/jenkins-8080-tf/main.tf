resource "google_compute_instance" "jenkins-8080-tf" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone = var.zone

  tags = ["jenkins-8080-tf","http-server"]

  metadata = {
   ssh-keys = "erkek:${file(var.public_key_path)}"
  }

  metadata_startup_script = ""

  #depends_on = ["google_compute_firewall.production-tf"]

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
  
}

resource "null_resource" "mongo-db-prov" {
 
connection {
    user = "erkek"
    host = "${google_compute_instance.jenkins-8080-tf.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = true   
  } 
  provisioner "file" {
    source      = "./modules/jenkins-8080-tf/scenario_jenkins.sh"
    destination = "~/scenario_jenkins.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/scenario_jenkins.sh",
      "sudo ~/scenario_jenkins.sh ${var.network_ip_production}",
    ]
  
  }

}
