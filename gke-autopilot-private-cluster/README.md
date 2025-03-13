# GKE Autopilot Private Cluster with Private API Endpoint

## Overview
This Terraform project provisions a GKE Autopilot Private Cluster with a private API endpoint, a bastion VM for secure access, and associated networking components (VPC, subnets, Cloud Router, Cloud NAT). It also configures IAM roles and permissions.

## Prerequisites
- Google Cloud SDK installed and configured.
- Terraform installed.

## Usage
1. Clone this repository.
2. Update `terraform.tfvars` with your GCP project ID and region.
3. Initialize Terraform:
   ```bash
   terraform init