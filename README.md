# tapir-docker
Docker container for the Tapir astronomy application

## Setup and run
* Make sure Docker is installed and running.  `cd` into the directory containing the Dockerfile
* `docker build -t tapir .`
* `docker run -dit --name tapir-app -p 8080:80 tapir`
* Visit localhost:8080 to see site
