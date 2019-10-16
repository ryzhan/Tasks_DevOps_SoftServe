output "network_ip_moodle" {
  value = "${google_compute_instance.moodle.network_interface.0.access_config.0.nat_ip}"
}

