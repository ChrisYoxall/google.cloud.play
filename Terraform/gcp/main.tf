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
  project = var.project
  region  = var.region
  zone    = var.zone
}

variable "project" {
  type    = string
  default = "terraform-play-387210"
}

variable "zone" {
  type    = string
  default = "australia-southeast1-a"
}

variable "region" {
  type    = string
  default = "australia-southeast1"
}


resource "google_compute_network" "network-one" {
  name                    = "network-one"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnet-one" {
  name          = "subnet-one"
  ip_cidr_range = "10.1.0.0/16"
  network       = google_compute_network.network-one.self_link
  region        = var.region
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.network-one.self_link
  target_tags   = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_instance" "vm_instance" {
  name         = "vm-one"
  machine_type = "n2-standard-2"

  network_interface {
    network    = google_compute_network.network-one.self_link
    subnetwork = google_compute_subnetwork.subnet-one.self_link
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
  scheduling {
    provisioning_model = "SPOT"
    preemptible        = true
    automatic_restart  = false
  }

  tags = ["allow-ssh"]

}

