package com.mycompany.servicehub.validator;

public class InputValidator {

    // Validate email format
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }

    // Validate password (min 6 characters)
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    // Check if fields are empty
    public static boolean isNotEmpty(String value) {
        return value != null && !value.trim().isEmpty();
    }

    // Validate NIC (Simple check for length, e.g., 10 or 12 digits)
    public static boolean isValidNIC(String nic) {
        return nic != null && (nic.length() == 10 || nic.length() == 12);
    }
}