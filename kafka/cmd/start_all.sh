#!/bin/bash
#https://medium.com/@williamleiby/command-line-interface-tmux-dabbd613ec2a
tmux new-session -s kfk -d
tmux split-window -h
tmux send-keys -t "kfk:0.0" C-z '$KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties' Enter
sleep 5
tmux send-keys -t "kfk:0.1" C-z '$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties' Enter
tmux attach -d