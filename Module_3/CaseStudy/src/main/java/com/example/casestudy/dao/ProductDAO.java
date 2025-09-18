package com.example.casestudy.dao;

import com.example.casestudy.model.Product;
import com.example.casestudy.service.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private static final String SELECT_ALL_PRODUCTS = "SELECT * FROM products";
    private static final String INSERT_PRODUCT = "INSERT INTO products (image, name, price) VALUES (?, ?, ?)";
    private static final String DELETE_PRODUCT = "DELETE FROM products WHERE id = ?";
    private static final String UPDATE_PRODUCT = "UPDATE products SET image = ?, name = ?, price = ? WHERE id = ?";
    private static final String FIND_ID = "SELECT * FROM products WHERE id = ?";
    private static final String SEARCH_PRODUCT = "SELECT * FROM products WHERE name LIKE ?";

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection()) {
            PreparedStatement ps = connection.prepareStatement(SELECT_ALL_PRODUCTS);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("image"),
                        rs.getString("name"),
                        rs.getDouble("price")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public void insertProduct(Product product) {
        try (Connection connection = DBConnection.getConnection()) {
            PreparedStatement ps = connection.prepareStatement(INSERT_PRODUCT);
            ps.setString(1, product.getImage());
            ps.setString(2, product.getName());
            ps.setDouble(3, product.getPrice());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int id) {
        try (Connection connection = DBConnection.getConnection()) {
            PreparedStatement ps = connection.prepareStatement(DELETE_PRODUCT);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Product getProductById(int id) {
        Product product = null;
        try (Connection connection = DBConnection.getConnection()) {
            PreparedStatement ps = connection.prepareStatement(FIND_ID);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product(
                        rs.getInt("id"),
                        rs.getString("image"),
                        rs.getString("name"),
                        rs.getDouble("price")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    public void updateProduct(Product product) {
        try (Connection connection = DBConnection.getConnection()) {
            PreparedStatement ps = connection.prepareStatement(UPDATE_PRODUCT);
            ps.setString(1, product.getImage());
            ps.setString(2, product.getName());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Product> searchProducts(String keyword) {
        Product product = null;
        List<Product> productList = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection()) {
            PreparedStatement ps = connection.prepareStatement(SEARCH_PRODUCT);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                product = new Product(
                        rs.getInt("id"),
                        rs.getString("image"),
                        rs.getString("name"),
                        rs.getDouble("price")
                );
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }
}

