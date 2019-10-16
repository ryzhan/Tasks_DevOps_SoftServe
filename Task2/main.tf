provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

module "moodle" {
  source = "./modules/moodle"  
  instance_name = "moodle"
}
