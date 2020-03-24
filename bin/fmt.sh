#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

echo
echo "--- Running goimports ..."
( cd ./src && goimports -w ./ )
