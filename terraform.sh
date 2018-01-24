#!/usr/bin/env bash
set -e

if [ "$#" -ne 2 ]
then
printf "Two parameters required. \n1. Terraform action (e.g. plan) \n2. Environment to run against (e.g. sandbox)"
exit 1
fi

TERRAFORM_ACTION=$1
ENVIRONMENT=$2

export GOOGLE_APPLICATION_CREDENTIALS=~/.google_cloud/account.json
cd environment-infrastructure
terraform init
terraform ${TERRAFORM_ACTION} -var-file=../variables/audit/environment.tfvars
