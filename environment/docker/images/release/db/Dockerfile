FROM mysql:5.7
MAINTAINER Simone Bembi <simone.bembi@gmail.com>

COPY environment/docker/configuration/mysql/docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

RUN chmod -R +x /docker-entrypoint-initdb.d

EXPOSE 3306