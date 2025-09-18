package com.example.projectbase.service;

import com.example.projectbase.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO implements GeneralDAO <Product>{
    private static final String SELECT_ALL_PRODUCTS = "SELECT * FROM Product";

    @Override
    public List<Product> findAll() {
        ArrayList<Product> listProduct = new ArrayList<>();
        try(Connection connection = DBConnection.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PRODUCTS)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next()) {
                int id = resultSet.getInt("ID");
                String name = resultSet.getString("Name");
                double price = resultSet.getDouble("Price");
                listProduct.add(new Product(id, name, price));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return listProduct;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
