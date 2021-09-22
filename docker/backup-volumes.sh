#!/bin/bash
set -x

# Import variables (common configuration)
source .env

BACKUP_FILE_NAME="./backup-$(docker context show)-${CDN_VOLUME_NAME}-$(date "+%Y-%m-%d_%H-%M-%S").tar"

# Backup served data
docker run \
    -i \
    --rm \
    -v "${CDN_VOLUME_NAME}:/opt/data:ro" \
    ubuntu \
    bash -c "set -x ; cd /opt/data && tar cvf - . || echo SOMETHING WENT WRONG >&2" |
    cat >"${BACKUP_FILE_NAME}"
