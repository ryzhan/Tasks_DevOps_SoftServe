output "network_ip_mongo" {
  #depends_on = ["null_resource.mongo-db-prov"]
  value = "${google_compute_instance.mongo-db-tf.network_interface.0.network_ip}"
}

