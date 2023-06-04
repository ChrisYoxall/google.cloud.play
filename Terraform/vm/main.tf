terraform {
  required_providers {

    // https://registry.terraform.io/providers/hashicorp/google/latest/docs
    google = {
      source  = "hashicorp/google"
      version = "4.67.0"
    }
  }
}


provider "google" {
  project = "terraform-play-387210"
  region  = "australia-southeast1"
  zone    = "australia-southeast1-a"
}

// Will need to enable the 'Compute Engine API' for the project

// https://cloud.google.com/vpc/docs/vpc
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_address" "static_ip" {
  name = "terraform-ip"
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "terraform-allow-ssh"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

// List images: gcloud compute images list --project XXXXX
// Look into 'cos-cloud/cos-stable' which is the Google container optimised OS designed to 
//  run Docker containers quickly, efficiently, and securely https://cloud.google.com/container-optimized-os/docs
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  tags = ["allow-ssh"]

}
