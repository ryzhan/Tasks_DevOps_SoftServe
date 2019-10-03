output "network_ip_cart" {
  #depends_on = ["null_resource.production-prov"]
  value = "${google_compute_instance.cart-tf.network_interface.0.network_ip}"
}