#!/bin/bash

docker compose stop
docker container rm $(docker container ls -aq)
docker rmi -f $(docker images -aq)
docker volume prune -f
docker network prune -f 
