# Temp build stage to copy maven config
#https://nickjanetakis.com/blog/benchmarking-debian-vs-alpine-as-a-base-docker-image
FROM debian:latest

# Install utils
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget curl vim git tmux mc locales && rm -rf /var/lib/apt/lists/
WORKDIR /tmp

# Configuration for tmux, change locale to en_US.UTF-8 the same as "locale-gen en_US.UTF-8" for Ubuntu
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && locale-gen

# Create folder for kafka
RUN mkdir /kafka

# Copy scripts
COPY cmd/* /kafka/cmd/

# Install Java11
#RUN apt-get update -y && apt-get install software-properties-common -y
#RUN add-apt-repository -y ppa:linuxuprising/java
RUN apt-get update -y && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean;
RUN apt-get update -y && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;
ENV JAVA_HOME='/usr/lib/jvm/java-11-openjdk-amd64'
ENV PATH=$PATH:$JAVA_HOME/bin
RUN echo export PATH=$PATH:$JAVA_HOME/bin >> /etc/environment
RUN java -version

# Install Kafka
RUN wget http://apache.ip-connect.vn.ua/kafka/3.2.1/kafka_2.13-3.2.1.tgz
RUN tar xzf kafka_2.13-3.2.1.tgz -C /kafka
ENV KAFKA_HOME=/kafka/kafka_2.13-3.2.1
COPY config/server0.properties /kafka/kafka_2.13-3.2.1/config
COPY config/server1.properties /kafka/kafka_2.13-3.2.1/config
COPY config/server2.properties /kafka/kafka_2.13-3.2.1/config

# Install Maven 3.8.3
RUN wget http://apache.ip-connect.vn.ua/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
RUN tar -xf apache-maven-3.8.6-bin.tar.gz -C /opt/
ENV MAVEN_HOME=/opt/apache-maven-3.8.6
ENV PATH=$PATH:$MAVEN_HOME/bin
RUN echo export PATH=$PATH:$MAVEN_HOME/bin >> /etc/environment
RUN update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.8.6/bin/mvn 99

# Startup
WORKDIR /kafka/cmd
CMD /kafka/cmd/start_all.sh
