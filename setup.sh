#!/bin/bash
set -o nounset

# Declare home directory
declare -r SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

# Init and apply terraform for backend; if dir not found, exit
cd "${SCRIPT_DIR}"/infrastructure/backend || exit 1
terraform init
terraform apply -auto-approve

# Go to infrastructure and init and apply terraform
cd ../infrastructure || exit 1
terraform init
terraform apply -auto-approve

# Go to base
cd ../..

# Get the EC2 instance variables
source "${SCRIPT_DIR}/script_vars.sh"
# Wait for instances to run
aws ec2 wait instance-running --instance-id "${web_id}"
aws ec2 wait instance-running --instance-id "${backend_id}"

sleep 5

# Go to service and run ansible
cd "${SCRIPT_DIR}"/service || exit 1
ansible-playbook -i ./inventory/webservers.yml playbook.yml
