provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

module "mongo-db-tf" {
  source = "./modules/mongo-db-tf"  
  instance_name = "mongo-db-tf"
 
  #depends_on = ["google_compute_firewall.allow-ssh"]
}

module "production-tf" {
  source = "./modules/production-tf"  
  instance_name = "production-tf"
  network_ip_mongo = module.mongo-db-tf.network_ip_mongo
}

