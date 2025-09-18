CREATE DATABASE webshop;
USE webshop;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price decimal(10, 2),
    image VARCHAR(200)
);

CREATE TABLE orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10, 2),
    status VARCHAR(20) DEFAULT 'pending'
);

CREATE TABLE orders_details (
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL
);

INSERT INTO admin(username, password) VALUES ('admin', '1');
SELECT * FROM admin
WHERE username = 'admin' AND password = '1';

Update admin
set password = '1'
where id = 1;

INSERT INTO products (image, name, price) VALUES
('images/laptop.jpg', 'Laptop Asus', 800),
('images/phone.jpg', 'Điện thoại Samsung', 480),
('images/headphone.jpg', 'Tai nghe Sony', 100),
('images/mouse.jpg', 'Chuột Logitech', 20),
('images/keyboard.jpg', 'Bàn phím cơ Razer', 60),
('images/monitor.jpg', 'Màn hình LG 24 inch', 140),
('images/ssd.jpg', 'Ổ cứng SSD 500GB', 64),
('images/ram.jpg', 'RAM 16GB DDR4', 52),
('images/speaker.jpg', 'Loa Bluetooth JBL', 72),
('images/powerbank.jpg', 'Pin dự phòng Xiaomi', 18),
('images/dashcam.jpg', 'Camera hành trình Xiaomi', 88),
('images/smartwatch.jpg', 'Smartwatch Apple Watch', 312),
('images/printer.jpg', 'Máy in Canon LBP 2900', 100),
('images/tablet.jpg', 'Máy tính bảng iPad Gen 9', 420),
('images/projector.jpg', 'Máy chiếu mini Anker', 184),
('images/airpods.jpg', 'Tai nghe AirPods Pro', 208),
('images/router.jpg', 'Router Wifi TP-Link', 36),
('images/cooler.jpg', 'Tản nhiệt laptop Cooler', 26),
('images/gamingmouse.jpg', 'Chuột gaming', 40),
('images/dell.jpg', 'Laptop Dell Inspiron', 740),
('images/rtx3050.jpg', 'RTX 3050', 1250);

select * from products;

DELETE FROM products WHERE id = 23;

Update products
SET name = 'Bàn phím Aula F87'
where id = 26;

ALTER TABLE products CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


