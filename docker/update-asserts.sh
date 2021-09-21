#!/bin/bash

# Import variables (common configuration)
source .env

# Update assets using temporary container
docker run \
    --rm \
    -v "${CDN_VOLUME_NAME}:/opt/old" \
    -v "$(pwd)/../server-files/cdn:/opt/new:ro" \
    ubuntu \
    bash -c "set -x; rm -rf /opt/old/asserts ; cp -v -f -r /opt/new/assets /opt/old/"
