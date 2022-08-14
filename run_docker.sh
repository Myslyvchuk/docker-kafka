#!/bin/bash

# remove old container if exists
kafka_container_id=$(docker ps -all --filter "name=kafka" --format "{{.ID}}")
echo "$kafka_container_id"
if [ ! -z "$kafka_container_id" ] ; then
  echo Deliting old container:
  docker container rm -f kafka
fi

#Kafka port
param=$param" -p 9092:9092"

mode=/kafka/cmd/start_all.sh
if [ "$1" == cluster ]; then
  mode=/kafka/cmd/start_cluster.sh
  # Mount volumes for kafka cluster
  param=$param" -v kafka_logs0:/tmp/kafka-logs0 -v kafka_logs1:/tmp/kafka-logs1 -v kafka_logs2:/tmp/kafka-logs2"

  param=$param" -p 9093:9093 -p 9094:9094"
else
  # Mount volume for kafka logs
  param=$param" -v kafka_logs:/tmp/kafka-logs"
fi
echo $mode

# Mount volume for maven local artifactory
param=$param" -v kafka_m2:/root/.m2/repository"

# Mount volume for zookeeper data
param=$param" -v zookeeper_data:/tmp/zookeeper"

#Zookeeper port
param=$param" -p 2181:2181"

# HOSTNAME
param=$param" --hostname localhost"

docker run --name kafka -it $param kafka $mode
