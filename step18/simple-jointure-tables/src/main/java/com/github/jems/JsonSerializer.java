package com.github.jems;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.common.serialization.Serializer;

import java.util.Map;

public class JsonSerializer<T> implements Serializer<T> {
    private final ObjectMapper OBJECT_MAPPER = new ObjectMapper();


    public void configure(Map<String, ?> configs, boolean isKey) {
    }

 
    public byte[] serialize(String topic, T data) {
        try {
            return data == null ? null : OBJECT_MAPPER.writeValueAsString(data).getBytes();
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }


    public void close() {
    }
}
