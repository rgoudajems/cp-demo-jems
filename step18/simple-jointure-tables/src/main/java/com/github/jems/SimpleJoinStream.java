package com.github.jems;

import org.apache.kafka.clients.admin.AdminClient;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.kstream.KTable;
import org.apache.kafka.streams.processor.WallclockTimestampExtractor;
import org.apache.kafka.streams.Consumed;
import org.apache.kafka.streams.KafkaStreams;
import  org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.Topology;

import java.util.Properties;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import static java.util.concurrent.TimeUnit.HOURS;


public class SimpleJoinStream {
    private static long windowRetentionTimeMs = HOURS.toMillis(4);

    public static void main(String[] args) throws Exception {
        new SimpleJoinStream().stream(args.length == 1 ? args[0] : "localhost:9092");
    }

    public void stream(String bootstrapServers) throws Exception {
        waitForTopics(bootstrapServers);

        // Serializer, Deserializer
        JsonSerde<Contact> contactSerde = new JsonSerde<>(Contact.class);
        JsonSerde<Adresse> adresseSerde = new JsonSerde<>(Adresse.class);


        StreamsBuilder builder = new StreamsBuilder();

        // Tables the 3 domain model topics

        KTable<String,Contact> tableContact = builder.table("SCONTACT_STREAM" , Consumed.with(Serdes.String(), contactSerde));
        KTable<String,Adresse> tableAddr_Per = builder.table("S_ADDR_PER_STREAM" , Consumed.with(Serdes.String(), adresseSerde));
        
        tableContact.join(
                tableAddr_Per,
                (member, address) -> new Aggregate().withContact(member).withAddresse(address),
                JoinWindows.of(SECONDS.toMillis(30)).until(windowRetentionTimeMs),
                Joined.with(Serdes.String(), contactSerde, addresseSerde))

     /*   String storeName = "joined-store";
        userRegions.join(userLastLogins,
                (regionValue, lastLoginValue) -> regionValue + "/" + lastLoginValue,
                Materialized.as(storeName))
                .toStream()
                .to(outputTopic, Produced.with(Serdes.String(), Serdes.String()));*/

        
   /*     members
        .filter((key, member) -> member != null && member.age > 18)
        .join(
                addresses.filter((key, address) -> address != null && "USA".equals(address.country)),
                (member, address) -> new Aggregate().withMember(member).withAddress(address),
                JoinWindows.of(SECONDS.toMillis(30)).until(windowRetentionTimeMs),
                Joined.with(Serdes.Integer(), memberSerde, addressSerde))
        .outerJoin(
                teams,
                (aggregate, team) -> (aggregate == null ? new Aggregate() : aggregate).withTeam(team),
                JoinWindows.of(SECONDS.toMillis(50)).until(windowRetentionTimeMs),
                Joined.with(Serdes.Integer(), aggregateSerde, teamSerde))
        .peek((k, aggregate) -> System.out.println(aggregate))
        .to(Aggregate.class.getSimpleName(), Produced.with(Serdes.Integer(), aggregateSerde));*/


       /* String storeName = "joined-store";
        tableContact
                .join(tableAddr_Per,
                		(aggregate, adresse) -> (aggregate == null ? new Aggregate() : aggregate).withAdresse(adresse),
                		
                        Joined.with(Serdes.String(), adresseSerde, teamSerde));*/




   // join return type "VR"es.Integer(), teamSerde));


        // SELECT * FROM members m
        //      INNER JOIN address a ON (m.id = a.id)
        //      LEFT OUTER JOIN team t on (m.id = t.id)
        //      WHERE m.age > 18
        //     AND a.country = "USA"


        Topology build = builder.build();

        System.out.println(build.describe());

        KafkaStreams kafkaStreams = new KafkaStreams(build, buildProducerProperties(bootstrapServers));
        kafkaStreams.cleanUp();
        kafkaStreams.start();
    }

    private void waitForTopics(String bootstrapServers) throws Exception {
        while (true) {
            TimeUnit.SECONDS.sleep(5);
            Properties properties = new Properties();
            properties.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
            AdminClient adminClient = AdminClient.create(properties);
            Set<String> topics = adminClient.listTopics().names().get();
         /*   if (topics.contains(Member.class.getSimpleName())) {
                return;
            }*/
            System.out.println("Waiting for data");
        }
    }

    private Properties buildProducerProperties(String bootstrapServers) {
        Properties properties = new Properties();
        properties.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        properties.put(StreamsConfig.NUM_STREAM_THREADS_CONFIG, 3);
        properties.put(StreamsConfig.APPLICATION_ID_CONFIG, "simple-join-stream");
        properties.put(StreamsConfig.COMMIT_INTERVAL_MS_CONFIG, 5 * 1000);
        properties.put(StreamsConfig.CACHE_MAX_BYTES_BUFFERING_CONFIG, 0);
        properties.put(StreamsConfig.DEFAULT_TIMESTAMP_EXTRACTOR_CLASS_CONFIG, WallclockTimestampExtractor.class);
        properties.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        properties.put(ProducerConfig.BATCH_SIZE_CONFIG, "1");
        properties.put(ProducerConfig.COMPRESSION_TYPE_CONFIG, "snappy");
        return properties;
    }
}

