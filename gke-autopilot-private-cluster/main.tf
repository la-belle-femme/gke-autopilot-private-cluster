provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source = "./modules/vpc"

  project_id = var.project_id
  region     = var.region
}

module "gke" {
  source = "./modules/gke"

  project_id          = var.project_id
  region              = var.region
  network             = module.vpc.network_name
  subnetwork          = module.vpc.subnets_names[0]
  master_ipv4_cidr_block = "10.0.4.0/28"
}

module "bastion" {
  source = "./modules/bastion"

  project_id = var.project_id
  zone       = var.zone
  network    = module.vpc.network_name
  subnetwork = module.vpc.subnets_names[0]
}

module "iam" {
  source = "./modules/iam"

  project_id = var.project_id
}