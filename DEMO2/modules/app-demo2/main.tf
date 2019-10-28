resource "google_compute_instance" "app-demo2" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone = var.zone

  tags = ["app-server","http-server"]

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
  
}

resource "null_resource" "app-demo2-prov" {
 
connection {
    type = "ssh"
    user = "erkek"
    host = "${google_compute_instance.app-demo2.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = false   
  }

  provisioner "file" {
    source      = "./modules/app-demo2/scenario_app.sh"
    destination = "~/scenario_app.sh"

  }

  provisioner "file" {
    source      = "./credential/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"

  }

  provisioner "file" {
    source      = "./modules/app-demo2/files/check-front-end.sh"
    destination = "/tmp/check-front-end.sh"

  }

  provisioner "file" {
    source      = "./modules/app-demo2/files/check-catalogue.sh"
    destination = "/tmp/check-catalogue.sh"

  }

  provisioner "file" {
    source      = "./modules/app-demo2/files/check-user.sh"
    destination = "/tmp/check-user.sh"

  }

  provisioner "file" {
    source      = "./modules/app-demo2/files/check-carts.sh"
    destination = "/tmp/check-carts.sh"

  }

  provisioner "remote-exec" {
    inline = [
      #"export MONGO_NETWORK_IP=${var.network_ip}",
      "chmod +x ~/scenario_app.sh",
      "sudo ~/scenario_app.sh ${var.network_ip_db}",
    ]
  
  }

}




