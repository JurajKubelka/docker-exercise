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
