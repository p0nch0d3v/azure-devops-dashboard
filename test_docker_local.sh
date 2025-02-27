#!/bin/bash

# Define variables
env_file='.env.docker'
image_name='azure-devops-dashboard:dev'
container_name='azure-devops-dashboard-dev'

# Stop and remove the container if it exists
docker container stop $container_name
docker container rm $container_name

# Remove the Docker image if it exists
docker image rm $image_name

# Build the Docker image
docker build \
    --progress plain \
    --no-cache \
    --tag $image_name \
    --debug \
    .

# Check if the .env.docker file exists and load environment variables
if [[ -e $env_file ]] then
    export $(cat $env_file | xargs)
    cat $env_file
fi

# Run the Docker container
docker run \
    --rm \
    --publish 5678:80 \
    --env MODE=$MODE \
    --env NODE_ENV=$NODE_ENV \
    --name $container_name \
    $image_name
