# Docker Exercises
An docker and docker-compose exercises.

## nginx with named volume

Create new container listening at 5680:
```shell
docker run -d -v nginx-test-volume:/usr/share/nginx/html -p 5680:80 --name nginx-test nginx:stable
```

If you stop and start again, the same files will be served as they are persisted in the volume called `nginx-test-volume`.
If you remove the `nginx-test` container and creates a new one, files remains persistent in the named volume.
If you remove also the volume, then the served data will be recreated.

### List Volume Files

You can list the data using:
```shell
docker run --rm -v nginx-test-volume:/opt/data:ro ubuntu ls -laR /opt/data
```

### Backup Volume

You can backup the `nginx-test-volume` as follows:
```shell
docker run --rm -v nginx-test-volume:/opt/data:ro -v "$(pwd):/opt/backup" ubuntu tar cvf /opt/backup/backup.tar /opt/data
```

### Restore Volume 

You can restore the `nginx-test-volume` as follows:
```shell
docker run --rm -v nginx-test-volume:/opt/data -v "$(pwd):/opt/backup:ro" ubuntu bash -c "cd /opt/data && tar xvf /opt/backup/backup.tar --strip 2"
```

## nginx Dockerfile

The [docker](docker) directory show how to build and run the nginx service with a named volume that contains particular files from [server-files](server-files).

In includes two shell scripts:
- [docker/build-services.sh](docker/build-services.sh): to build a new docker image
- [docker/run-services.sh](docker/run-services.sh): to create and run new docker container, which also includes a backup commands

Notice, that we cannot access [server-files](server-files) from the [docker/web](docker/web) directory. For that reason we copy the directory [server-files](server-files) into the [docker/web](docker/web). When a new image is built, we remove the copied files. I did not find better solution, as the `docker -f docker/web/Dockerfile` from the top directory generates other issues that are reported in several occasions on StackOverflow and yet no satisfactory solution provided. If you have better working solution, please, let me know.

## Updating Named Volume Content

When [server-files](server-files) are updated, the named volume keeps the same old files. To update the existing volume content, we need to create a new container, similar to the backup one, that updates the volume content.

We can update the content using a temporal container. The [docker/update-assets.sh](docker/update-assets.sh) script exemplify such situation, updating `assets` directory.

## docker-compose.yml 

[docker-compose/docker-compose.yml](docker-compose/docker-compose.yml) shows how to define a service that uses the docker image created by [docker/build-services.sh](docker/build-services.sh) and use the existing volume created by [docker/run-services.sh](docker/run-services.sh).
