resource "google_compute_instance" "server-db-demo2" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone = var.zone
  tags = ["server-db"]

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

resource "null_resource" "server-db-demo2-prov" {
 
connection {
    type = "ssh"
    user = "erkek"
    host = "${google_compute_instance.server-db-demo2.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = false   
  } 

  provisioner "file" {
    source      = "./credential/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"

  }

  provisioner "file" {
    source      = "./modules/server-db-demo2/scenario_db.sh"
    destination = "/tmp/scenario_db.sh"

  }

  provisioner "remote-exec" {
    inline = [
      #"export MONGO_NETWORK_IP=${var.network_ip}",
      "chmod +x /tmp/scenario_db.sh",
      "sudo /tmp/scenario_db.sh ${google_compute_instance.server-db-demo2.network_interface.0.network_ip}",
    ]
  
  }

}