/*package com.github.jems;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.github.javafaker.Faker;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.IntegerSerializer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.admin.AdminClient;
import org.apache.kafka.clients.admin.*;
import java.security.SecureRandom;
import java.util.*;
import java.util.concurrent.TimeUnit;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;


/**
 * Look at the data produced, by example:
 * kafka-console-consumer --bootstrap-server localhost:9092 --topic Team --property print.key=true --key-deserializer org.apache.kafka.common.serialization.IntegerDeserializer --from-beginning
 */
/*
public class RandomProducer {
    private static final Faker faker = new Faker();
    private static final SecureRandom random = new SecureRandom();
    public static final int NB_START_TEAMS = 5;
    public static final int NB_START_MEMBERS = 40;
    private int nbTeams = 0;
    private int nbMembers = 0;

    //Les Contacts a envoyés
    public static List<Contact> buildContacts() {
        List<Contact> lescontacts= new ArrayList<Contact>();
        Contact C1 = new Contact("L1","Luis");
        Contact C2 = new Contact("A2","Aram");
        lescontacts.add(C1);
        lescontacts.add(C2);
        return lescontacts;
    }
  //Les Adresses a envoyés
    public static List<Adresse> buildAddress() {
        List<Adresse> lesAdresses= new ArrayList<Adresse>();
        Adresse A1 = new Adresse("L1","Rue de Boulogne");
        Adresse A2 = new Adresse("A2","Rue de Saint Cyr");
        lesAdresses.add(A1);
        lesAdresses.add(A2);
        return lesAdresses;
    }

    private Producer<String, String> buildProducer(String bootstrapServers) {
        try {
            TimeUnit.SECONDS.sleep(20);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        props.put(ProducerConfig.ACKS_CONFIG, "all");
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, IntegerSerializer.class.getName());
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, JsonSerializer.class.getName());
        props.put(ProducerConfig.BATCH_SIZE_CONFIG, 10);
        props.put(ProducerConfig.COMPRESSION_TYPE_CONFIG, "snappy");
        return new KafkaProducer<>(props);
    }

    public void produce(String bootstrapServers) throws InterruptedException {
        Producer<String, String> producer = buildProducer(bootstrapServers);

        // create starting teams
        List<Contact> contacts = buildContacts();
        List<Adresse> addresses = buildAddress();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        for (int i=0; i< contacts.size(); i ++){
            try {
                producer.send(new ProducerRecord<String,String>("Contacts",contacts.get(i).getId().toString(), ow.writeValueAsString(contacts.get(i)).toString()));

            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }


        }


    }

    public static void main(String args[]) throws InterruptedException {
        new RandomProducer().produce(args.length == 1 ? args[0] : "localhost:9092");
    }

}*/
