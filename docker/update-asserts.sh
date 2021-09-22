#!/bin/bash

# Import variables (common configuration)
source .env

# Update assets using temporary container
tar cvf - --strip-components 3 ../server-files/cdn/assets |
    docker run \
        -i \
        --rm \
        -v "${CDN_VOLUME_NAME}:/opt/data" \
        ubuntu \
        bash -c "set -x; cd /opt/data && if [ -d assets ] ; then rm -rv assets ; fi && tar xvf - || echo SOMETHING WENT WRONG >&2"
