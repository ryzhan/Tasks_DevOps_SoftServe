resource "google_compute_instance" "mongo-db-tf" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone = var.zone
  tags = ["mongo-tf"]

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

resource "null_resource" "mongo-db-prov" {
 
connection {
    type = "ssh"
    user = "erkek"
    host = "${google_compute_instance.mongo-db-tf.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = false   
  } 

  provisioner "file" {
    source      = "./credential/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"

  }

  provisioner "file" {
    source      = "./modules/mongo-db-tf/scenario_mongo.sh"
    destination = "/tmp/scenario_mongo.sh"

  }

  provisioner "remote-exec" {
    inline = [
      #"export MONGO_NETWORK_IP=${var.network_ip}",
      "chmod +x /tmp/scenario_mongo.sh",
      "sudo /tmp/scenario_mongo.sh ${google_compute_instance.mongo-db-tf.network_interface.0.network_ip}",
    ]
  
  }

}