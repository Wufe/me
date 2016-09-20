FROM mysql:5.7
MAINTAINER Simone Bembi <simone.bembi@gmail.com>

COPY environment/docker/configuraton/mysql/docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

RUN chmod -R +x /docker-entrypoint-initdb.d

PORT 3306