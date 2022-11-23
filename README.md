# tapir-docker
Docker container for the [Tapir astronomy application](https://github.com/elnjensen/Tapir)

## Setup and run
* Make sure Docker is installed and running.  `cd` into the directory containing the Dockerfile
* Build image: `docker build -t tapir .`
* Start container: `docker run -dit --name tapir-app -p 8080:80 tapir`
* Visit localhost:8080 to see site
* Stop container: `docker stop tapir-app`
