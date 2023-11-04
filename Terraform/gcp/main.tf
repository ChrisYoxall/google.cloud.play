// Taken from tutorials at https://rnemet.dev/tags/terraform/

terraform {

  cloud {
    organization = "chris-demo"
    workspaces {
      name = "GCP"
    }
  }

  required_providers {

    // https://registry.terraform.io/providers/hashicorp/google/latest/docs
    google = {
      source  = "hashicorp/google"
      version = "5.4.0"
    }
  }
}

provider "google" {
  project = "terraform-play-387210"
  region  = "australia-southeast1"
  zone    = "australia-southeast1-a"
}

resource "google_compute_network" "network-one" {
  name                    = "network-one"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}