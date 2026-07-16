package scratch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DbTest {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/servicehub_db";
        String user = "root";
        String password = "";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(url, user, password)) {
                System.out.println("Connection successful!");
                
                // Let's try inserting with budget = 0.0
                String query = "INSERT INTO service_requests (customer_id, service_title, category, budget, status, city) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setInt(1, 1); // Umasha user_id = 1
                    ps.setString(2, "Need Service at Colombo");
                    ps.setString(3, "Cleaning");
                    ps.setDouble(4, 0.0); // budget
                    ps.setString(5, "Pending");
                    ps.setString(6, "Colombo");
                    
                    int rows = ps.executeUpdate();
                    System.out.println("Insert successful, rows affected: " + rows);
                } catch (SQLException e) {
                    System.out.println("SQL Execution failed:");
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
