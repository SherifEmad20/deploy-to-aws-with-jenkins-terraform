#! /bin/bash

echo "Waiting for application to run..."

sleep 120

# Get the public IP of the AWS EC2 instance
public_ip=$(terraform output -raw server_ip)

echo "Public IP of the EC2 instance: $public_ip"

# Curl to the public IP
while true; do
    curl_result=$(curl "http://$public_ip:8080/api/course/getCourses") && break  # Break the loop on successful connection
    sleep 120
done


# Display the result
echo "Curl Result:"
echo "$curl_result"
