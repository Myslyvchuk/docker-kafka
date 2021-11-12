#!/bin/bash

# remove old container if exists
kafka_container_id=$(docker ps -all --filter "name=kafka" --format "{{.ID}}")
echo "$kafka_container_id"
if [ ! -z "$kafka_container_id" ] ; then
  echo Deliting old container:
  docker container rm -f kafka
fi
# Mount volume for kafka logs
param=$param" -v kafka_logs:/tmp/kafka-logs"

# Mount volume for maven local artifactory
param=$param" -v kafka_m2:/root/.m2/repository"

# Mount volume for zookeeper data
param=$param" -v zookeeper_data:/tmp/zookeeper"

#Kafka port
param=$param" -p 9092:9092"

#Zookeeper port
param=$param" -p 2181:2181"


# HOSTNAME
param=$param" --hostname localhost"

docker run --name kafka -it $param kafka
