output "network_ip_mongo" {
  value = "${google_compute_instance.mongo-db-tf.network_interface.0.network_ip}"
}