#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

bash ./bin/fmt.sh

rm -rf ./_dist
mkdir ./_dist

echo
echo "--- Downloading dependencies ..."
( cd ./src && go mod download )

echo
echo "--- Building app ..."
( cd ./src && go build -o ../_dist/app ./ )

echo
echo "--- Running app ..."
./_dist/app
