resource "google_compute_instance" "cart-tf" {
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

resource "null_resource" "cart-prov" {
 
connection {
    type = "ssh"
    user = "erkek"
    host = "${google_compute_instance.cart-tf.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = false   
  }

  provisioner "file" {
    source      = "./modules/cart-tf/scenario_cart.sh"
    destination = "~/scenario_cart.sh"

  }

  provisioner "file" {
    source      = "./credential/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"

  }

  provisioner "remote-exec" {
    inline = [
      #"export MONGO_NETWORK_IP=${var.network_ip}",
      "chmod +x ~/scenario_cart.sh",
      "sudo ~/scenario_cart.sh ${var.network_ip_db}",
    ]
  
  }

}




