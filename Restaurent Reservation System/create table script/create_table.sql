-- Roles table
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL
);

-- Users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    telephone VARCHAR(15),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role_id INT REFERENCES roles(role_id)
);

-- Restaurants table
CREATE TABLE restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    address TEXT,
    telephone VARCHAR(15),
    open_time TIME,
    close_time TIME
);

-- Reservations table
CREATE TABLE reservations (
    reservation_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    restaurant_id INT REFERENCES restaurants(restaurant_id),
    reservation_date DATE,
    reservation_time TIME,
    table_count INT CHECK (table_count BETWEEN 1 AND 3)
);

-- Makes table (associative table for M:N relationship)
CREATE TABLE makes (
    user_id INT REFERENCES users(user_id),
    reservation_id INT REFERENCES reservations(reservation_id),
    PRIMARY KEY (user_id, reservation_id)
);

-- Logs table
CREATE TABLE logs (
    log_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    action_type VARCHAR(50),
    action_date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default roles
INSERT INTO roles (role_name) VALUES ('admin'), ('user');

-- Enable cryptographic functions
CREATE EXTENSION IF NOT EXISTS pgcrypto;