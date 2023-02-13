#!/bin/sh

NAME=devcon

# launch terminal session
docker run -it -rm --name ${NAME} ${NAME}:latest /bin/bash
