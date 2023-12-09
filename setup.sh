#!/bin/bash
set -o nounset

# Declare home directory
declare -r SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

# Init and apply terraform for backend; if dir not found, exit
cd "${SCRIPT_DIR}"/backend || exit 1
terraform init
terraform apply -auto-approve

# Go to infrastructure and init and apply terraform
cd ../infrastructure || exit 1
terraform init
terraform apply -auto-approve

# Get the EC2 instance variables
cd .. || exit 1
source "${SCRIPT_DIR}/instances.sh"

# Wait for instances to run
aws ec2 wait instance-running --instance-id "${web_id}"
aws ec2 wait instance-running --instance-id "${backend_id}"
sleep 10

# Go to service and run ansible
ansible-playbook -i "${SCRIPT_DIR}/service/inventory/webservers.yml" "${SCRIPT_DIR}/service/playbook.yml"

echo "Service Running on:"
echo "${web_dns}"
echo ""
