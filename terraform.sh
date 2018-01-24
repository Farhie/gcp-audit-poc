#!/usr/bin/env bash
set -e

if [ "$#" -ne 1 ]
then
printf "Must supply Terraform action [plan/apply/destroy]"
exit 1
fi

TERRAFORM_ACTION=$1

export GOOGLE_APPLICATION_CREDENTIALS=~/.google_cloud/account.json
cd environment-infrastructure
terraform init
terraform ${TERRAFORM_ACTION} -var-file=../variables/environment.tfvars
