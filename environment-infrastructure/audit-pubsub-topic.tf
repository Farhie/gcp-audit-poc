resource "google_pubsub_topic" "audit_poc_topic" {
  name    = "audit-poc-topic"
  project = "${var.project}"
}

data "template_file" "set_project_in_cloud_function" {
  template = "${file("../cloud-functions/triggering-off-pubsub-insert/template/index.template")}"

  vars {
    gcp_project = "${var.project}"
  }
}

//resource "local_file" "js" {
//  content      = "${data.template_file.set_project_in_cloud_function.rendered}"
//  filename = "../cloud-functions/triggering-off-pubsub-insert/function/index.js"
//}
//data "archive_file" "cloud_function_archive" {
//  type        = "zip"
//  source_dir  = "../cloud-functions/triggering-off-pubsub-insert/function/"
//  output_path = "../cloud-functions/triggering-off-pubsub-insert/message-ingress-pubsub.zip"
//  depends_on  = ["local_file.js"]
//}


data "archive_file" "cloud_function_archive" {
  type        = "zip"
  output_path = "../cloud-functions/triggering-off-pubsub-insert/message-ingress-pubsub.zip"

  source {
    content  = "${data.template_file.set_project_in_cloud_function.rendered}"
    filename = "index.js"
  }

  source {
    content  = "${file("../cloud-functions/triggering-off-pubsub-insert/function/package.json")}"
    filename = "package.json"
  }

  source {
    content  = "${file("../cloud-functions/triggering-off-pubsub-insert/function/package-lock.json")}"
    filename = "package.json"
  }
}

resource "google_storage_bucket_object" "message_ingress_to_pubsub_archive" {
  name   = "message-ingress-pubsub.zip"
  bucket = "${google_storage_bucket.cloud_functions_bucket.name}"
  source = "${data.archive_file.cloud_function_archive.output_path}"
  depends_on = ["data.archive_file.cloud_function_archive"]
}

resource "google_cloudfunctions_function" "update_on_insert_to_pubsub_function" {
  name                  = "audit-insert-to-pubsub"
  description           = "Write out to console upon insert"
  available_memory_mb   = 128
  source_archive_bucket = "${google_storage_bucket.cloud_functions_bucket.name}"
  source_archive_object = "${google_storage_bucket_object.message_ingress_to_pubsub_archive.name}"
  trigger_topic         = "${google_pubsub_topic.audit_poc_topic.name}"
  timeout               = 60
  entry_point           = "writeToSpanner"
  project               = "${var.project}"
}
