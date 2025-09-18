CREATE DATABASE ProductManagement;
USE ProductManagement;

CREATE TABLE Product(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2)
);

INSERT INTO Product (Name, Price)
VALUES
('IPhone 16 Pro Max', 1190),
('Redmi K50 Ultra', 490),
('Samsung Galaxy S23', 799),
('Vivo U10', 200),
('Samsung Galaxy S24 Ultra', 1299);


 
