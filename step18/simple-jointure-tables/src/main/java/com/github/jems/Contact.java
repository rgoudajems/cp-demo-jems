package com.github.jems;

/**
 * Created by rayanegouda on 16/03/2018.
 */
public class Contact {
    public String id;
    public String Name;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public Contact(String id, String name) {

        this.id = id;
        Name = name;
    }
}
