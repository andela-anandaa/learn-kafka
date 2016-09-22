const logger = require('winston');
const Kafka = require('no-kafka');
const producer = new Kafka.Producer();

let topic = 'test-topic';

// simple producer
return producer.init().then(() => {
  return producer.send({
    topic,
    partition: 0,
    message: {
      key: '120x',
      value: {
        name: 'Austin',
        class: '1',
      }
    }
  });
})
.then((result) => {
  logger.info('res: ', result);
  process.exit();
});