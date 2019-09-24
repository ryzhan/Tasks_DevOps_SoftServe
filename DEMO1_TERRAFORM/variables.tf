variable "credentials" {
  description = "CREDENTIALS_JSON_PATH"
  default = "/home/erkek/!!!SoftServe-if-101-devops/Tasks_DevOps_SoftServe/DEMO1_TERRAFORM/arctic-plasma-248716-9bc5c7955a26.json"
}

variable "project" {
  description = "Project ID"
  default     = "arctic-plasma-248716"
}

variable "region" {
  description = "Region"
  default     = "us-east1"
}

variable "zone" {
  description = "Zone"
  default     = "us-east1-b"
}

variable "machine_type" {
  description = "The machine type to create"
  default     = "f1-micro"
}

variable "disk_image" {
  description = "centos-7"
  default     = "centos-7-v20190916"
}

variable "network" {
  description = "The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided."
  default     = "default"
}

variable "subnetwork" {
  description = "The name or self_link of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
  default     = ""
}

variable "subnetwork_project" {
  description = "The project in which the subnetwork belongs. If the subnetwork is a self_link, this field is ignored in favor of the project defined in the subnetwork self_link. If the subnetwork is a name and this field is not provided, the provider project is used."
  default     = ""
}

variable "network_ip" {
  description = "The private IP address to assign to the instance. If empty, the address will be automatically assigned."
  default     = ""
}

variable "nat_ip" {
    description = "The IP address that will be 1:1 mapped to the instance's network ip. If not given, one will be generated."
    default     = ""
}
variable "public_key_path" {
  description = "public key for user Erkek"
  default     = "/home/erkek/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  default     = "/home/erkek/.ssh/id_rsa"
}