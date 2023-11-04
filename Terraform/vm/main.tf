terraform {

  cloud {
    organization = "chris-demo"
    workspaces {
      name = "VM"
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


// https://cloud.google.com/vpc/docs/vpc
resource "google_compute_network" "vpc_network" {
  name = "test-network"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_address" "static_ip" {
  name = "vm-ip"
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "n2-standard-2"

  scheduling {
    provisioning_model = "SPOT"
    preemptible        = true
    automatic_restart  = false
  }


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
