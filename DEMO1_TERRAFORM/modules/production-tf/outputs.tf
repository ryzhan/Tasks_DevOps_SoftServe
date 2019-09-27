output "network_ip_production" {
  depends_on = ["null_resource.production-prov"]
  value = "${google_compute_instance.production-tf.network_interface.0.network_ip}"
}