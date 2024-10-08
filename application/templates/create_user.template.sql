CREATE USER IF NOT EXISTS `${USERNAME}`@'%' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON `${USERNAME}\_%`.* TO `${USERNAME}`@'%';

CREATE DATABASE IF NOT EXISTS `${USERNAME}_banco`;
USE `${USERNAME}_banco`;

CREATE TABLE IF NOT EXISTS exemplo (
        id INT PRIMARY KEY,
        name VARCHAR(255),
        email VARCHAR(255)
);
REPLACE INTO exemplo (id,name,email) VALUES(1,"exemplo","exemplo@abc.com");
