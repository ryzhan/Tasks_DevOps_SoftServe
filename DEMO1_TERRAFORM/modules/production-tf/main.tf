resource "google_compute_instance" "production-tf" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone = var.zone

  tags = ["production-tf","http-server"]

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

resource "null_resource" "production-prov" {
 
connection {
    user = "erkek"
    host = "${google_compute_instance.production-tf.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = true   
  }

  provisioner "file" {
    source      = "./modules/production-tf/scenario_production.sh"
    destination = "~/scenario_production.sh"

  }

  provisioner "file" {
    source      = "./credential/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"

  }

  provisioner "remote-exec" {
    inline = [
      #"export MONGO_NETWORK_IP=${var.network_ip}",
      "chmod +x ~/scenario_production.sh",
      "sudo ~/scenario_production.sh ${var.network_ip_mongo}",
    ]
  
  }

}




