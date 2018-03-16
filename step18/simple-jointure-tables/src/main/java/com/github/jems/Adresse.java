package com.github.jems;

/**
 * Created by rayanegouda on 16/03/2018.
 */
public class Adresse {
    public String id;
    public String streetName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStreetName() {
        return streetName;
    }

    public void setStreetName(String streetName) {
        this.streetName = streetName;
    }

    public Adresse(String id, String streetName) {

        this.id = id;
        this.streetName = streetName;
    }
}
