#!/bin/bash
set -x

# Import variables (common configuration)
source .env

# Run web service
docker stop "${CONTAINER_NAME}"
docker rm "${CONTAINER_NAME}"
docker run --name "${CONTAINER_NAME}" -p 5678:80 -v "${CDN_VOLUME_NAME}:${NGINX_MOUNT_POINT}" -d "${IMAGE_NAME}"

# Backup served data
docker run --rm -v "${CDN_VOLUME_NAME}:/opt/data:ro" -v "$(pwd):/opt/backup" ubuntu tar cvf "/opt/backup/backup-$(date "+%Y-%m-%d_%H-%M-%S").tar" /opt/data
