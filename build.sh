#!/bin/sh
NAME=devcon

# rebuild and reload the container
docker build -t ${NAME} .

# scan container for vulnerabilities
#docker scan --accept-license ${NAME}

#docker run -it --name ${NAME} ${NAME}:latest /bin/bash
