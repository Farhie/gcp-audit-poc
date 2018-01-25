//resource "google_spanner_instance" "audit_poc_spanner_instance" {
//  config       = "regional-us-central1"
//  display_name = "audit-poc-instance"
//  name         = "audit-poc-instance"
//  num_nodes    = 1
//  project      = "${var.project}"
//}
//
//resource "google_spanner_database" "audit_poc_spanner_database" {
//  instance = "${google_spanner_instance.audit_poc_spanner_instance.name}"
//  name     = "audit-poc-spanner-table"
//  project  = "${var.project}"
//}
