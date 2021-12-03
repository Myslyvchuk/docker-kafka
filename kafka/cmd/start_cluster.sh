#!/bin/bash
tmux new-session -s kfk -d;
tmux split-window -h;
tmux split-window -v;
tmux select-pane -t 0;
tmux split-window -v;

tmux send-keys -t "kfk:0.0" C-z '$KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties' Enter
sleep 5
tmux send-keys -t "kfk:0.1" C-z '$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server0.properties' Enter
sleep 5
tmux send-keys -t "kfk:0.2" C-z '$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server1.properties' Enter
sleep 5
tmux send-keys -t "kfk:0.3" C-z '$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server2.properties' Enter
tmux attach -d