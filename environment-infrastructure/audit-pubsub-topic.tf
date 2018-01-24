resource "google_pubsub_topic" "audit_poc_topic" {
  name    = "audit-poc-topic"
  project = "${var.project}"
}

resource "google_storage_bucket_object" "archive" {
  name   = "message-ingress-pubsub.zip"
  bucket = "${google_storage_bucket.cloud_functions_bucket.name}"
  source = "../lib/message-ingress-pubsub.zip"
}

resource "google_cloudfunctions_function" "update_on_insert_to_pubsub_function" {
  name                  = "audit-insert-to-pubsub"
  description           = "Write out to console upon insert"
  available_memory_mb   = 128
  source_archive_bucket = "${google_storage_bucket.cloud_functions_bucket.name}"
  source_archive_object = "${google_storage_bucket_object.archive.name}"
  trigger_topic         = "${google_pubsub_topic.audit_poc_topic.name}"
  timeout               = 60
  entry_point           = "helloPubSub"
}