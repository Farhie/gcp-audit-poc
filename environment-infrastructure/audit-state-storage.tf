resource "google_spanner_database" "audit_poc_state_table" {
  instance = "${google_spanner_instance.audit_poc_spanner_instance.name}"
  name     = "audit-poc-state-machine-table"

  ddl = [
    "CREATE TABLE Events (Event  STRING(1024), Id INT64 NOT NULL) PRIMARY KEY(Id)",
  ]
}
