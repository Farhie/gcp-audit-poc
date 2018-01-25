# gcp-audit-poc
PoC to understand how to build an automated auditing tool that is HA in Google cloud. Likely to be state machine based.

## Out of Scope
As this is a PoC, the following are out of scope:
- Handling Terraform state. 

## Running
- Create a project and note the name
- Create a service account and place the credentials in `~/.google_cloud/account.json`
- To plan `./terraform.sh plan [PROJECT_NAME]`
- To apply `./terraform.sh plan [PROJECT_NAME]`