#!/bin/bash
docker container rm -f kafka
docker image rm -f kafka
docker volume rm kafka_logs
docker volume rm kafka_m2
