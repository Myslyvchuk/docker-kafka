# Temp build stage to copy maven config
FROM debian:stretch

# Install utils
RUN apt-get update && apt-get upgrade && apt-get install -y wget curl vim git tmux mc locales && rm -rf /var/lib/apt/lists/
WORKDIR /tmp

# Configuration for tmux, change locale to en_US.UTF-8 the same as "locale-gen en_US.UTF-8" for Ubuntu
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && locale-gen

# Create folder for kafka
RUN mkdir /kafka

# Copy scripts
COPY bin/* /kafka/bin/

# Install Java11
#RUN apt-get update && apt-get install software-properties-common -y
#RUN add-apt-repository -y ppa:linuxuprising/java
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get clean;
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;
ENV JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
ENV PATH=$PATH:$JAVA_HOME/bin
RUN echo export PATH=$PATH:$JAVA_HOME/bin >> /etc/environment
RUN java -version

# Install Kafka
RUN wget http://apache.ip-connect.vn.ua/kafka/2.4.0/kafka_2.13-2.4.0.tgz
RUN tar xzf kafka_2.13-2.4.0.tgz -C /kafka
ENV KAFKA_HOME=/kafka/kafka_2.13-2.4.0

# Install Maven 3.3.9
RUN wget http://apache.ip-connect.vn.ua/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
RUN tar -xf apache-maven-3.6.3-bin.tar.gz -C /opt/
ENV MAVEN_HOME=/opt/apache-maven-3.6.3
ENV PATH=$PATH:$MAVEN_HOME/bin
RUN echo export PATH=$PATH:$MAVEN_HOME/bin >> /etc/environment
RUN update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.6.3/bin/mvn 99

# Startup
WORKDIR /kafka/bin
ENTRYPOINT /kafka/bin/start_all.sh
