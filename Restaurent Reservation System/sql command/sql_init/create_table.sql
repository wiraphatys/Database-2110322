-- Table creation for 'role'
CREATE TABLE IF NOT EXISTS role (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL
);

-- Table creation for 'user'
CREATE TABLE IF NOT EXISTS "user" (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(255) NOT NULL UNIQUE,
    role_id INT REFERENCES role(role_id)
);

-- Table creation for 'restaurant'
CREATE TABLE IF NOT EXISTS restaurant (
    restaurant_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    branch VARCHAR(255),
    address TEXT NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(255)
);

-- Table creation for 'table'
CREATE TABLE IF NOT EXISTS "table" (
    table_id SERIAL PRIMARY KEY,
    capacity INT NOT NULL,
    restaurant_id INT REFERENCES restaurant(restaurant_id)
);

-- Table creation for 'reserve'
CREATE TABLE IF NOT EXISTS reserve (
    reserve_id SERIAL PRIMARY KEY,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    date DATE NOT NULL,
    user_id INT REFERENCES "user"(user_id),
    table_id INT REFERENCES "table"(table_id),
    status VARCHAR(50) NOT NULL
);

-- Table creation for 'review'
CREATE TABLE IF NOT EXISTS review (
    review_id SERIAL PRIMARY KEY,
    description TEXT,
    user_id INT REFERENCES "user"(user_id),
    restaurant_id INT REFERENCES restaurant(restaurant_id)
);

-- Table creation for 'log'
CREATE TABLE IF NOT EXISTS log (
    log_id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    date_time TIMESTAMP NOT NULL,
    user_id INT REFERENCES "user"(user_id)
);
