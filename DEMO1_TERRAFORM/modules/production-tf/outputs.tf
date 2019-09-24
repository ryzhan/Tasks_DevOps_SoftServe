output "network_ip_production" {
  value = "${google_compute_instance.production-tf.network_interface.0.network_ip}"
}