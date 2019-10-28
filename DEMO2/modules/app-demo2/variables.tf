variable "network_ip" {
  description = "The private IP address to assign to the instance. If empty, the address will be automatically assigned."
  default     = ""
}

variable "nat_ip" {
    description = "The IP address that will be 1:1 mapped to the instance's network ip. If not given, one will be generated."
    default     = ""
}

variable "instance_name" {
  description = "Instance name"
  default     = ""
}

variable "user_name" {
  description = "User name"
  default     = "erkek"
}

variable "zone" {
  description = "Zone"
  default     = "us-east1-b"
}

variable "machine_type" {
  description = "The machine type to create"
  default     = "g1-small"
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

variable "public_key_path" {
  description = "public key for user Erkek"
  default     = "./credential/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  default     = "./credential/id_rsa"
}

variable "deploy_public_key_path" {
  description = "public key for user Erkek"
  default     = "./credential/deploy.pub"
}

variable "network_ip_db" {
  description = "local ip mongo db"
  default     = ""
}