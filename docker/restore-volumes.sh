#!/bin/bash

# Define backup file name
BACKUP_FILE_NAME="$1"

if [ -z "${BACKUP_FILE_NAME}" ]; then
    echo "ERROR: No backup file specified as the first argument" >&2
    exit 1
fi

if [ ! -r "${BACKUP_FILE_NAME}" ]; then
    echo "ERROR: The backup file does not exist or is not readable: ${BACKUP_FILE_NAME}" >&2
    exit 2
fi

set -x

# Import variables (common configuration)
source .env

# Update assets using temporary container
cat "${BACKUP_FILE_NAME}" |
    docker run \
        -i \
        --rm \
        -v "${CDN_VOLUME_NAME}:/opt/data" \
        ubuntu \
        bash -c "set -x ; cd /opt/data && rm -rvf * && tar xvf - || echo SOMETHING WENT WRONG >&2"
