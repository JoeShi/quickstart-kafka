FROM confluentinc/cp-kafka-connect:5.2.1

COPY connect-standalone.properties /root/
COPY quickstart-s3.properties /root/

ENTRYPOINT ["connect-standalone", "/root/connect-standalone.properties", "/root/quickstart-s3.properties"]
