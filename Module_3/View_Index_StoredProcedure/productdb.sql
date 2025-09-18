CREATE DATABASE productdb;
USE productdb;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DOUBLE
);

INSERT INTO products (name, price) VALUES
('Chuột máy tính', 150000),
('Bàn phím cơ', 500000),
('Màn hình 24 inch', 2500000);
