#!/bin/bash 
set -x

# Import variables (common configuration)
source .env

SERVER_FILES="server-files"

# Build web service
cd web

## remove subdirectory server-files
rm -rf "${SERVER_FILES}"
cp -r "../../${SERVER_FILES}" .

## build image
docker build -t "${IMAGE_NAME}" .

## clean subdirectory server-files
rm -r "${SERVER_FILES}" 
