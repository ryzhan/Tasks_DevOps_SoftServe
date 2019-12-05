provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

module "jenkins-8080-tf" {
  source = "./modules/jenkins-8080-tf"  
  instance_name = "jenkins-8080-tf"
}
