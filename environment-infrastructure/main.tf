terraform {
  required_version = "0.11.2"
}

provider "google" {
  project = "audit-poc"
  region  = "us-central1"
}
