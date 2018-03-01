# Objective 

Debezium et MySql

```
$ docker-compose exec connect curl -s -XPOST -H "Content-Type: application/json; charset=UTF-8" http://localhost:8083/connectors/ -d '
{
    "name": "debezium-connector",
    "config": {
        "connector.class": "io.debezium.connector.mysql.MySqlConnector",
        "tasks.max": "1",
        "database.hostname": "mysql",
        "database.port": "3306",
        "database.user": "debezium",
        "database.password": "dbz",
        "database.server.id": "223344",
        "database.server.name": "dbserver1",
        "database.whitelist": "db",
        "database.history.kafka.bootstrap.servers": "kafka-1:9092,kafka-2:9092,kafka-3:9092",
        "database.history.kafka.topic": "schema-changes.db"
    }
}'
```

 Statut du connecteur
 
```sh
$ docker-compose exec connect curl -s localhost:8083/connectors/debezium-connector/status | jq .
{
  "name": "debezium-connector",
  "connector": {
    "state": "RUNNING",
    "worker_id": "connect:8083"
  },
  "tasks": [
    {
      "state": "RUNNING",
      "id": 0,
      "worker_id": "connect:8083"
    }
  ],
  "type": "source"
}
```
 
Liste des topics

```sh 
$ docker-compose exec kafka-1 kafka-topics --zookeeper zookeeper:2181 --list
__consumer_offsets
_schemas
connect-config
connect-offsets
connect-status
dbserver1
dbserver1.db.S_ADDR_PER
dbserver1.db.S_CONTACT
dbserver1.db.S_CONTACT_X
dbserver1.db.S_RESP
dbserver1.db.S_USER
schema-changes.db
```


Consomation du topic  dbserver1.db.S_CONTACT

```
$ docker-compose exec schema-registry kafka-avro-console-consumer -bootstrap-server kafka-1:9092,kafka-2:9092,kafka-3:9092 --topic dbserver1.db.S_CONTACT --from-beginning --property schema.registry.url=http://localhost:8082

{"before":null,"after":{"dbserver1.db.S_CONTACT.Value":{"ROW_ID":"1","SEND_NEWS_FLG":{"string":"1"},"HARD_TO_REACH":{"string":"1"},"SEX_MF":{"string":"HOMME"},"X_DATE_ACCES_WEB":{"int":17588},"EMAIL_ADDR":{"string":"test@gmail.com"},"SEND_FIN_FLG":{"string":"1"},"FAX_PH_NUM":{"string":"0098652467896457"},"PRACTICE_TYPE":{"string":"test pratice type"},"LAST_NAME":"Polo","X_ACC_CONT_MAIL_FAX_FLG":{"string":"1"},"PREF_COMM_METH_CD":{"string":""},"FST_NAME":"FST_NAME","SUPPRESS_MAIL_FLG":"1","SUPPRESS_CALL_FLG":"1","WORK_PH_NUM":{"string":"00000366886444"},"CELL_PH_NUM":{"string":"00000366886444"},"ASST_PH_NUM":{"string":"00000366886444"},"PR_RESP_ID":{"string":"11"},"COMMENTS":{"string":"COMMENTS "},"X_SUPPRIME_FLG":{"string":"1"}}},"source":{"version":{"string":"0.7.3"},"name":"dbserver1","server_id":223344,"ts_sec":1519657798,"gtid":null,"file":"mysql-bin.000005","pos":2215,"row":0,"snapshot":null,"thread":{"long":2},"db":{"string":"db"},"table":{"string":"S_CONTACT"}},"op":"c","ts_ms":{"long":1519657804048}

```

Conncetion au ksql client 

```
docker-compose exec ksql-cli ksql-cli local --bootstrap-server kafka-1:9092

```

Create  STREAM

```
CREATE STREAM USER_TEST  ( ROW_ID VARCHAR, LOGIN VARCHAR ) WITH ( kafka_topic='dbserver1.db.S_USER', value_format='JSON');

```

Perfect!

