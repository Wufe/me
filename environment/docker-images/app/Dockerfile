FROM kesshin/php70:latest
MAINTAINER Simone Bembi<simone.bembi@gmail.com>

COPY dist/app /app
RUN chmod -R 777 /app

WORKDIR /app

EXPOSE 9000

ENTRYPOINT php-fpm