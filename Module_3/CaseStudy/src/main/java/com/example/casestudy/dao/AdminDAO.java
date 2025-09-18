package com.example.casestudy.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {
    private final String USER_PASS = "SELECT * FROM admin WHERE username = ? AND password = ?";
    private Connection connection;

    public AdminDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean login(String username, String password) {
        try {
            PreparedStatement ps = connection.prepareStatement(USER_PASS);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
