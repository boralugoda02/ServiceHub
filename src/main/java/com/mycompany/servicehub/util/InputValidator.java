package com.mycompany.servicehub.util;

import java.util.regex.Pattern;

public class InputValidator {

    // 1. Check if a string is empty or null
    public static boolean isNotEmpty(String input) {
        return input != null && !input.trim().isEmpty();
    }

    // 2. Validate email format using simple Regex
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return email != null && Pattern.matches(emailRegex, email);
    }

    // 3. Validate password length (minimum 6 characters)
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    // 4. Validate NIC (10 or 12 digits/characters)
    public static boolean isValidNIC(String nic) {
        if (nic == null) return false;
        // Allows 10 digits/letters or exactly 12 digits
        return nic.matches("^[0-9]{9}[vVxX]$") || nic.matches("^[0-9]{12}$");
    }
}