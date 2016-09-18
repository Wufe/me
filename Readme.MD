# Web Platform Template 
### Scaffolding template

The purpose of this repository is to provide a scaffolding template for a generic web platform, providing the four stages of continuous delivery:  
+ test  
+ build  
+ release  
+ deploy  

In order to accomplish portability the project will use `docker` and `docker-compose`.  

#### Requirements

+ `docker 1.12+`  
+ `docker-compose 1.8.0+`  
+ `gnu make`  

#### Installation and first start

+ `make run`

#### Start  

+ `make start`

## Info  

This course was based upon  

+ Pluralsight's ["RESTful Web Services with PHP and Laravel"](https://app.pluralsight.com/library/courses/php-laravel-restful-web-services/table-of-contents)  
+ Devdojo's ["Laravel 5.3 basics"](https://devdojo.com/series/laravel-5-3-basics)  
+ Pluralsight's ["Continuous Delivery Using Docker And Ansible"](https://app.pluralsight.com/library/courses/docker-ansible-continuous-delivery/table-of-contents)

It was a repo used to study Laravel and continuous delivery workflow.

##### Binaries

The bin folder contains binaries for artisan, composer, npm and node, using docker.  

##### Using this template

The `src` folder will contain the source code for the frontend and the backend of the platform.  

In order to change the application path, you need to specify it in  
`docker/compose/app.yml` under `services->app->volumes`.  

E.g:  

*before*
```
app:
  image: busybox
  volumes:
    - ../../../src/backend:/app
```  

*after*
```
app:
  image: busybox
  volumes:
    - ../../../src/backend/src/release:/app
```