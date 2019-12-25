FROM confluentinc/cp-kafka-connect:5.3.1

COPY worker.properties /root/
COPY kinesis-streams-kafka-connector.properties /root/
COPY amazon-kinesis-kafka-connector-0.0.9-SNAPSHOT.jar /usr/local/share/kafka/plugins

ENTRYPOINT ["connect-standalone", "/root/worker.properties", "/root/kinesis-streams-kafka-connector.properties"]
