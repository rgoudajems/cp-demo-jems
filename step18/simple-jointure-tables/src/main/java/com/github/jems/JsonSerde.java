package com.github.jems;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.apache.kafka.common.serialization.Deserializer;
import org.apache.kafka.common.serialization.Serde;
import org.apache.kafka.common.serialization.Serializer;

import java.io.IOException;
import java.util.Map;

public class JsonSerde<T> implements Serde<T> {
    private final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    private final Class clazz;

    public JsonSerde(Class<T> clazz) {
        this.clazz = clazz;
    }


    public void configure(Map<String, ?> configs, boolean isKey) {
    }

   
    public void close() {
    }

 
    public Serializer<T> serializer() {
        return new JsonSerializer<T>();
    }

 
    public Deserializer<T> deserializer() {
        return new Deserializer<T>() {
 
            public void configure(Map<String, ?> configs, boolean isKey) {

            }

       
            public T deserialize(String topic, byte[] data) {
                try {
                    return data == null ? null : (T) OBJECT_MAPPER.readValue(data, clazz);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }

            public void close() {

            }
        };
    }
}


