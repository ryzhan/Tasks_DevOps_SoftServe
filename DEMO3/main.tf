provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

#module "server-db-demo2" {
#  source = "./modules/server-db-demo2"  
#  instance_name = "server-db-demo2"
#}

#module "app-demo2" {
#  source = "./modules/app-demo2"  
#  instance_name = "app-demo2"
#  network_ip_db = module.server-db-demo2.network_ip_db
#}

module "jenkins-8080-tf" {
  source = "./modules/jenkins-8080-tf"  
  instance_name = "jenkins-8080-tf"
#  network_ip_app = module.app-demo2.network_ip_app
#  network_ip_db = module.server-db-demo2.network_ip_db
}
