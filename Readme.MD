# Me!
### Personal Website Repository

Coded using `Laravel 5.3`, `React 15.3`.  

In order to accomplish portability the project will use `docker` and `docker-compose`.  

#### Requirements

+ `docker 1.12+`  
+ `docker-compose 1.8.0+`  
+ `gnu make`  

#### Installation

+ `make install`

#### Start  

+ `make development`  

This will start a development environment

#### `Makefile` commands

 + `make run`: install development environment and starts it.
 + `make install`: installs all dependencies and runs post-install scripts.
 + `make test`: starts development environment and runs tests.
 + `make wipe`: deletes dependencies and temporary volumes folders.
 + `make development`: start development environment.
 + `make development WATCH=false`: start development environment without webpack build and watch. It is true by default.
 + `make development QUIET=true`: quiet mode.
 + `make development STOP=true`: stop containers. It will also remove them by default.
 + `make development STOP=true REMOVE=false`: stop containers but don't remove them.
 + `make development KILL=true`: kill containers and remove them by default.
 + `make development WIPE=true`: kill containers and remove them mandatorily.
 + `make watch`: uses started development environment to build code with webpack and watch.

## Info  

This code was based upon  

+ Pluralsight's ["RESTful Web Services with PHP and Laravel"](https://app.pluralsight.com/library/courses/php-laravel-restful-web-services/table-of-contents)  
+ Devdojo's ["Laravel 5.3 basics"](https://devdojo.com/series/laravel-5-3-basics)  
+ Pluralsight's ["Continuous Delivery Using Docker And Ansible"](https://app.pluralsight.com/library/courses/docker-ansible-continuous-delivery/table-of-contents)

It was a repo used to study Laravel and continuous delivery workflow.  
The code evolved into a personal project.

##### Binaries

The bin folder contains binaries for artisan, composer, npm and node, using docker.  

##### Destination

The website will be hosted [here](https://simone.bembi.me).