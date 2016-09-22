FROM kesshin/php70:latest
MAINTAINER Simone Bembi <simone.bembi@gmail.com>

ARG DB_NAME
ARG DB_USER
ARG DB_PASS

ENV DB_DATABASE=$DB_NAME
ENV DB_USERNAME=$DB_USER
ENV DB_PASSWORD=$DB_PASS

COPY dist /app
COPY environment/docker/images/production/app/config/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY environment/docker/images/production/app/config/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN chmod -R 777 /app

WORKDIR /app

EXPOSE 9000

ENTRYPOINT php-fpm