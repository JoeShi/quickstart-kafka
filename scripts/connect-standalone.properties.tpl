bootstrap.servers=${kafkaList}
schemas.enable=false
key.converter=org.apache.kafka.connect.json.JsonConverter
value.converter=org.apache.kafka.connect.json.JsonConverter
key.converter.schemas.enable=false
value.converter.schemas.enable=false
offset.storage.file.filename=/tmp/connect.offsets
offset.flush.interval.ms=10000


plugin.path=/usr/share/java,/usr/share/confluent-hub-components
