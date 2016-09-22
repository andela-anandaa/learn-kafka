const logger = require('winston');
const Kafka = require('no-kafka');
const consumer = new Kafka.SimpleConsumer();

let topic = 'test-topic';

// simple consumer
let dataHandler = (messageSet, topic, partition) => {
  // console.log(messageSet, topic, partition);
  messageSet.forEach((m) => {
    console.log(topic, partition, m.offset, m.message.value);
  });
};

return consumer.init().then(() => {
  // subscribe partitions 0 and 1 in a topic
  return consumer.subscribe(topic, dataHandler);
  // other options:
  // consumer.subscribe('kafka-test-topic', 0, {time: Kafka.LATEST_OFFSET}, dataHandler)
  // consumer.subscribe('kafka-test-topic', 0, {time: Kafka.EARLIEST_OFFSET}, dataHandler)
  // subscribe to all partitions in a topic
  // consumer.subscribe('kafka-test-topic', dataHandler)
});