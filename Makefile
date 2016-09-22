KAFKA_ROOT=~/dev/kafka/kafka_2.10-0.10.0.0
TOPIC=test-topic
FACTOR=1 # replication factor

# start Zookeeper
start_zk:
	cd $(KAFKA_ROOT) && bin/kafka-server-start.sh config/server.properties

start_server: start_zk
	cd $(KAFKA_ROOT) && bin/zookeeper-server-start.sh config/zookeeper.properties

create_topic:
	cd $(KAFKA_ROOT) && bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor $(FACTOR) --partitions 3 --topic $(TOPIC)

list_topics:
	cd $(KAFKA_ROOT) && bin/kafka-topics.sh --list --zookeeper localhost:2181

send_message:
	cd $(KAFKA_ROOT) && bin/kafka-console-producer.sh --broker-list localhost:9092 --topic $(TOPIC)

start_consumer:
	cd $(KAFKA_ROOT) && bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic $(TOPIC) --from-beginning

describe_topics:
	$(KAFKA_ROOT)/bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic $(TOPIC)

# start more nodes
more_nodes:
	$(KAFKA_ROOT)/bin/kafka-server-start.sh config/server-1.properties &
	$(KAFKA_ROOT)/bin/kafka-server-start.sh config/server-2.properties &

# alias
sz: start_zk
ss: start_server
sc: start_consumer
ct: create_topic
dt: describe_topics
ls: list_topics
send: send_message
