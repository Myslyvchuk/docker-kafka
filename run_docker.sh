#!/bin/bash

# remove old container if exists
kafka_container_id=$(docker ps -all --filter "name=test_kafka" --format "{{.ID}}")
echo "$kafka_container_id"
if [ ! -z "$kafka_container_id" ] ; then
  echo Deliting old container:
  docker rm test_kafka
fi
# Mount volume for kafka logs
#param=$param" -v test_kafka_logs:/tmp/kafka-logs"

# Mount volume for maven local artifactory
param=$param" -v test_kafka_m2:/root/.m2/repository"

#Kafka port
param=$param" -p 9092:9092"

# HOSTNAME
param=$param" --hostname localhost"

docker run --name test_kafka -it $param test_kafka
