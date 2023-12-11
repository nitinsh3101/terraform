terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.82.0"
    }
  }
}

provider "google" {
  credentials = file("nitin-project-gcp-f59d1b30e206.json")
  project     = "nitin-project-gcp"
  region      = "us-central1"  
}   

#Add permissions
resource "google_project_iam_binding" "ServiceAgent" {
  project = "nitin-project-gcp"
  role    = "roles/serverless.serviceAgent"
  members  = ["serviceAccount:github-auth-gcr@nitin-project-gcp.iam.gserviceaccount.com"]
}

resource "google_project_iam_binding" "Cloud" {
  project = "nitin-project-gcp"
  role    = "roles/run.admin"
  members  = ["serviceAccount:github-auth-gcr@nitin-project-gcp.iam.gserviceaccount.com"]
}

resource "google_project_iam_binding" "ArtifactsRegistry" {
  project = "nitin-project-gcp"
  role    = "roles/artifactregistry.admin"
  members  = ["serviceAccount:github-auth-gcr@nitin-project-gcp.iam.gserviceaccount.com"]
}

# Create Artifacts repository
resource "google_artifact_registry_repository" "telescope-frontend" {
  repository_id = "telescope-frontend-terraform"
  project      = "nitin-project-gcp"
  location     = "us-central1"  
  format       = "docker"
  depends_on = [ google_project_iam_binding.ArtifactsRegistry ]
}

resource "google_artifact_registry_repository" "telescope-backend" {
  repository_id = "telescope-backend-terraform"
  project      = "nitin-project-gcp"
  location     = "us-central1"  
  format       = "docker"
  depends_on = [ google_project_iam_binding.ArtifactsRegistry ]
}

#Create Clour run service
resource "google_cloud_run_v2_service" "telescope-frontend-terraform" {
  name     = "telescope-frontend-terraform-1"
  location = "us-central1"
  template {
    containers {
        image = "us-central1-docker.pkg.dev/nitin-project-gcp/telescope-frontend-terraform/frontend:latest"
        ports {
          container_port = 4200
        }
      }
  }
  traffic {
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

resource "google_cloud_run_v2_service" "telescope-backend-terraform" {
  name     = "telescope-backend-terraform-1"
  location = "us-central1"
  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  template {
    containers {
        image = "us-central1-docker.pkg.dev/nitin-project-gcp/telescope-backend-terraform/backend:latest"
        ports {
          container_port = 9081
        }
        env {
          name  = "DB_USERNAME"
          value = "telescope"
        }
        env {
          name  = "DB_HOST"
          value = "10.128.0.10"
        }
        env {
          name  = "DB_NAME"
          value = "wfh_reporting"
        }
        env {
          name = "DB_PASSWORD"
          value_source {
            secret_key_ref {
              secret = "cloud-run-telescope-db-secret"
              version = "1"
            }
          }
        }  
      }
    }
  traffic {
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}
