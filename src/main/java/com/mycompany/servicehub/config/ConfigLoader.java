package com.mycompany.servicehub.config;

import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader {
    private static Properties properties = new Properties();

    static {
        try (InputStream input = ConfigLoader.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input != null) {
                properties.load(input);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getProperty(String key) {
        String value = properties.getProperty(key);
        if (value != null) {
            return value;
        }
        switch (key) {
            case "db.url":
                return "jdbc:mysql://localhost:3306/servicehub_db";
            case "db.username":
                return "root";
            case "db.password":
                return "";
            default:
                return null;
        }
    }
}