#!/bin/bash
set -eoxu pipefail

cd "$(dirname "$0")"

docker build . -t live555
docker build . -t live555-snapfuzzz -f Dockerfile-snapfuzz