# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

variable "node_zone_locations" {
  default = ["us-east1-b", "us-east1-c"]
}

# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location       = var.region
  version_prefix = "1.27"
}

resource "google_container_cluster" "primary" {
  name     = "nitin-gke"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.primary.name
  location = var.region
  cluster  = google_container_cluster.primary.name

  version    = data.google_container_engine_versions.gke_version.version_prefix
  node_count = var.gke_num_nodes

  node_locations = var.node_zone_locations

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = "nitin-dev"
    }

    preemptible  = true
    machine_type = "e2-medium"
    tags         = ["gke-node", "nitin-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

