FROM mysql:5.7
MAINTAINER Simone Bembi <simone.bembi@gmail.com>

ARG DB_ROOT_PASS
ARG DB_NAME
ARG DB_USER
ARG DB_PASS

ENV MYSQL_ROOT_PASSWORD=$DB_ROOT_PASS
ENV MYSQL_DATABASE=$DB_NAME
ENV MYSQL_USER=$DB_USER
ENV MYSQL_PASSWORD=$DB_PASS

COPY environment/docker/images/production/db/provision /docker-entrypoint-initdb.d

RUN chmod -R +x /docker-entrypoint-initdb.d

EXPOSE 3306