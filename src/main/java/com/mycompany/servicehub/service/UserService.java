package com.mycompany.servicehub.service;

import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.model.User;
import com.mycompany.servicehub.exception.AppException;

public class UserService {
    private UserDAO userDAO = new UserDAO();

    public boolean registerUser(User user) throws AppException {
        try {
            userDAO.saveUser(user);
            return true;
        } catch (Exception e) {
            throw new AppException("Registration failed: " + e.getMessage());
        }
    }

    public User loginUser(String email, String password) throws AppException {
        try {
            User user = userDAO.getUserByEmail(email);
            if (user != null && user.getPassword().equals(password)) {
                return user;
            }
            return null;
        } catch (Exception e) {
            throw new AppException("Login error: " + e.getMessage());
        }
    }
}