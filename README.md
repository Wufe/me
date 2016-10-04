# Me!
### Personal Website Repository

Coded using `Laravel 5.3`, `React 15.3`.  

In order to accomplish portability the project will use `docker` and `docker-compose`.  

#### Requirements

+ `docker 1.12+`  
+ `docker-compose 1.8.0+`  
+ `gnu make`  

#### Installation and Start 

+ `make development`  

This will start a development environment

#### `Makefile` commands

 + `make watch`: uses started development environment to build code with webpack and watch.
 + `make start`: runs environment built with `make development`.
 + `make development`: start development environment.
 + `make production`: builds and starts production environment.

## Info  

##### Binaries

The bin folder contains binaries for artisan and npm executed using docker.

##### Destination

The website will be hosted [here](https://simone.bembi.me).