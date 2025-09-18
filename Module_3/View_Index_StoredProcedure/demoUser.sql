create database demo;
use demo;

create table users(
	id int primary key auto_increment,
    name nvarchar(100) not null,
    email varchar(50) not null,
    country varchar(100)
);

insert into users(name, email, country) values('Minh','minh@codegym.vn','Viet Nam');
insert into users(name, email, country) values('Kante','kante@che.uk','Kenia');