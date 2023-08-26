#! /bin/bash

sudo apt update -y

sudo apt upgrade -y

sudo apt install docker docker.io -y >> logs.txt

sudo chmod 666 /var/run/docker.sock

docker logout 

docker login -uUsername -pPassword

docker pull sherifemad21/school-backend:v-1

docker run -d -p 8080:8081 sherifemad21/school-backend:v-1
