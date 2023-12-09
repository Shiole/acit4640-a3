#!/bin/bash
set -o nounset

declare -r SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

# destroy all infrastructure
cd "${SCRIPT_DIR}"/infrastructure || exit 1
terraform destroy -auto-approve

# destroy backend
cd ../backend || exit 1
terraform destroy -auto-approve
