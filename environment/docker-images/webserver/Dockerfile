FROM nginx:latest
MAINTAINER Simone Bembi <simone.bembi@gmail.com>

COPY dist/assets /assets
RUN chmod -R 777 /assets

COPY environment/docker-images/webserver/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /assets

EXPOSE 80