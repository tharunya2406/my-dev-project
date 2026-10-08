FROM httpd:latest

RUN apt update

COPY devops-project2/index.html /usr/local/apache2/htdocs/
