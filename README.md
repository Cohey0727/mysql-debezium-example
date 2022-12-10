# MySQL Debezium Example

This demo automatically deploys the topology of services as defined in the [Debezium Tutorial](https://debezium.io/documentation/reference/stable/tutorial.html).

- [MySQL Debezium Example](#mysql-debezium-example)
  - [Environment](#environment)
  - [Using MySQL](#using-mysql)
  - [Debugging](#debugging)

## Environment

| name           | version                |
| -------------- | ---------------------- |
| Docker Compose | 3.9                    |
| MySQL          | arm64v8/mysql:8.0      |
| kafka          | debezium/kafka:2.0     |
| zookeeper      | debezium/zookeeper:2.0 |
| debezium       | debezium/connect:2.0   |

## Using MySQL

```shell
# Start the topology as defined in https://debezium.io/documentation/reference/stable/tutorial.html
export DEBEZIUM_VERSION=2.0
docker-compose up

# Start MySQL connector
# なぜかconnectorを登録する前に、DataGripなどで疎通確認しないと登録できない
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-mysql.json

# Delete MySQL connector
curl -X DELETE http://localhost:8083/connectors/example-connector

# Consume messages from a Debezium topic
docker-compose exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic dbserver1.inventory.customers

# Modify records in the database via MySQL client
docker-compose exec mysql bash -c 'mysql -u root -p$MYSQL_PASSWORD mysql'

# Shut down the cluster
docker-compose down
```

## Debugging

Should you need to establish a remote debugging session into a deployed connector, add the following to the `environment` section of the `connect` in the Compose file service:

    - KAFKA_DEBUG=true
    - DEBUG_SUSPEND_FLAG=n
    - JAVA_DEBUG_PORT=*:5005

Also expose the debugging port 5005 under `ports`:

    - 5005:5005

You can then establish a remote debugging session from your IDE on localhost:5005.
