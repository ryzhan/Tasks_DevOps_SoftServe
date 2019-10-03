provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

module "mongo-db-tf" {
  source = "./modules/mongo-db-tf"  
  instance_name = "mongo-db-tf"
}

module "production-tf" {
  source = "./modules/production-tf"  
  instance_name = "production-tf"
  network_ip_mongo = module.mongo-db-tf.network_ip_mongo
}

module "jenkins-8080-tf" {
  source = "./modules/jenkins-8080-tf"  
  instance_name = "jenkins-8080-tf"
  network_ip_cart = module.cart-tf.network_ip_cart
}
