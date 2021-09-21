# from the ./ directory, execute:
#   docker build -t dummy-web:latest .
#   docker stop dummy-instance
#   docker rm dummy-instance
#   docker run --name dummy-instance -p 5678:80 -d dummy-web
FROM nginx:stable
#RUN rm -rf /usr/share/nginx/html/*
COPY server-files/cdn /usr/share/nginx/html
