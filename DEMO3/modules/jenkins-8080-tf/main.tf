resource "google_compute_instance" "jenkins-8080-tf" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone = var.zone

  tags = ["jenkins-8080-tf","http-server"]

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

resource "null_resource" "jenkins-8080-prov" {
 
connection {
    type = "ssh"
    user = "erkek"
    host = "${google_compute_instance.jenkins-8080-tf.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = false   
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
      source      = "./credential/if-101-demo1-02c2a2eae285.json"
      destination = "/tmp/if-101-demo1-02c2a2eae285.json"

    }

  # provisioner "file" {
  #     source      = "./credential/read-registry.json"
  #     destination = "/tmp/read-registry.json"

  #   }

  provisioner "file" {
      source      = "./modules/jenkins-8080-tf/scenario_jenkins.sh"
      destination = "~/scenario_jenkins.sh"

    }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/scenario_jenkins.sh",
      "~/scenario_jenkins.sh",
    ]
  
  }

}

resource "null_resource" "jenkins-8080-add-job" {
 
depends_on = ["null_resource.jenkins-8080-prov"]

connection {
    type = "ssh"
    user = "erkek"
    host = "${google_compute_instance.jenkins-8080-tf.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = false   
  } 

  provisioner "file" {
    source      = "./modules/jenkins-8080-tf/files/terraform-infrastucture.xml"
    destination = "~/terraform-infrastucture.xml"
  }

  provisioner "file" {
    source      = "./modules/jenkins-8080-tf/files/front-end.xml"
    destination = "~/front-end.xml"
  }

  provisioner "file" {
    source      = "./modules/jenkins-8080-tf/files/catalogue.xml"
    destination = "~/catalogue.xml"
  }

  provisioner "file" {
    source      = "./modules/jenkins-8080-tf/files/carts.xml"
    destination = "~/carts.xml"
  }

  provisioner "remote-exec" {
    inline = [
        "sleep 60",
        "sudo java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:admin -s 'http://localhost:8080/' create-job terraform-infrastucture  < terraform-infrastucture.xml",
        "sudo java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:admin -s 'http://localhost:8080/' create-job front-end  < front-end.xml",
        "sudo java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:admin -s 'http://localhost:8080/' create-job catalogue  < catalogue.xml",
        "sudo java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:admin -s 'http://localhost:8080/' create-job carts  < carts.xml"
    ]
  
  }

}