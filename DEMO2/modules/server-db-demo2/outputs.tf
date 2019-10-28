output "network_ip_db" {
  depends_on = ["null_resource.server-db-demo2-prov"]
  value = "${google_compute_instance.server-db-demo2.network_interface.0.network_ip}"
}

