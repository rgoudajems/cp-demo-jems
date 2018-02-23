

docker-compose exec connect curl -s http://localhost:8083/connector-plugins | jq .
[
  {
    "class": "com.github.cjmatta.kafka.connect.irc.IrcSourceConnector",
    "type": "source",
    "version": "4.0.0"
  },
  {
    "class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
    "type": "sink",
    "version": "4.0.0"
  },
  {
    "class": "io.confluent.connect.hdfs.HdfsSinkConnector",
    "type": "sink",
    "version": "4.0.0"
  },
  {
    "class": "io.confluent.connect.hdfs.tools.SchemaSourceConnector",
    "type": "source",
    "version": "1.0.0-cp1"
  },
  {
    "class": "io.confluent.connect.jdbc.JdbcSinkConnector",
    "type": "sink",
    "version": "4.0.0"
  },
  {
    "class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "type": "source",
    "version": "4.0.0"
  },
  {
    "class": "io.confluent.connect.replicator.ReplicatorSourceConnector",
    "type": "source",
    "version": "4.0.0"
  },
  {
    "class": "io.confluent.connect.s3.S3SinkConnector",
    "type": "sink",
    "version": "4.0.0"
  },
  {
    "class": "io.confluent.connect.storage.tools.SchemaSourceConnector",
    "type": "source",
    "version": "1.0.0-cp1"
  },
  {
    "class": "org.apache.kafka.connect.file.FileStreamSinkConnector",
    "type": "sink",
    "version": "1.0.0-cp1"
  },
  {
    "class": "org.apache.kafka.connect.file.FileStreamSourceConnector",
    "type": "source",
    "version": "1.0.0-cp1"
  }
]
