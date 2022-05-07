terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

terraform {
  backend "local" {
    path = "/opt/ansible/inventory/terraform.tfstate"
  }
}


provider "google" {
  credentials = file("/opt/ansible/inventory/service-account.json")

  project = "studied-radar-341118"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_service_account" "default" {
  account_id   = "server-serveice-account"
  display_name = "server service account"
}

resource "google_compute_instance" "default" {
  name         = "app-server"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["http-server", "default-allow-ssh", "https-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }



  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
