resource "google_compute_instance" "jenkins-8080-tf" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone = var.zone

  tags = ["jenkins-8080-tf","http-server"]

  metadata = {
   ssh-keys = "${var.user_name}:${file(var.public_key_path)}"
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

resource "null_resource" "jenkins-8080-prov" {
 
connection {
    user = "erkek"
    host = "${google_compute_instance.jenkins-8080-tf.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = true   
  } 

  provisioner "file" {
    source      = "./credential/id_rsa"
    destination = "/tmp/id_rsa"

  }

  provisioner "file" {
    source      = "./credential/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"

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

