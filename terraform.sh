#!/usr/bin/env bash
set -e

if [ "$#" -ne 2 ]
then
printf "Must supply Terraform action [plan/apply/destroy] and project name."
exit 1
fi

TERRAFORM_ACTION=$1
PROJECT=$2

export GOOGLE_APPLICATION_CREDENTIALS=~/.google_cloud/account.json
cd environment-infrastructure
terraform init
terraform ${TERRAFORM_ACTION} -var-file=../variables/environment.tfvars -var "project=${PROJECT}"
