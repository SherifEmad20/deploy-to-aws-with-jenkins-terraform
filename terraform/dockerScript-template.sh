#! /bin/bash

sudo apt update -y

sudo apt upgrade -y

sudo apt install docker docker.io -y

sudo chmod 666 /var/run/docker.sock

docker logout 

docker login -uUsername -pPassword

docker pull DockerImageToPull

docker run -d -p 8080:8081 DockerImageToPull
