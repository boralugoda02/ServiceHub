package com.mycompany.servicehub.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = ConfigLoader.getProperty("db.url");
            String user = ConfigLoader.getProperty("db.username");
            String password = ConfigLoader.getProperty("db.password");
            if (url == null) {
                url = "jdbc:mysql://localhost:3306/servicehub_db";
            }
            if (user == null) {
                user = "root";
            }
            if (password == null) {
                password = "";
            }
            conn = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
}