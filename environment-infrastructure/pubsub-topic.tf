resource "google_pubsub_topic" "audit_poc_topic" {
  name    = "audit-poc-topic"
  project = "${var.project}"
}
