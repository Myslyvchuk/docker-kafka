#!/bin/bash
docker container rm -f kafka
docker image rm -f kafka
docker volume rm kafka_logs
docker volume rm kafka_logs0
docker volume rm kafka_logs1
docker volume rm kafka_logs2
docker volume rm kafka_m2