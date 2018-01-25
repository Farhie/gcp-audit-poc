resource "google_storage_bucket" "cloud_functions_bucket" {
  name     = "audit-poc-cloud-functions-bucket"
  location = "${var.default_region}"
  project  = "${var.project}"
}
