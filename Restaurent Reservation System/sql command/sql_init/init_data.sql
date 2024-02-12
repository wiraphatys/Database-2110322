-- Insert initial data into 'role' table
INSERT INTO role (role_name) VALUES ('admin'), ('user');

-- Insert initial data into 'user' table
-- Assuming role_id 1 is for admin and 2 is for regular users
INSERT INTO "user" (username, password, name, phone, email, role_id) VALUES
('adminUser', 'adminPass', 'Admin Name', '1234567890', 'admin@example.com', 1),
('regularUser', 'userPass', 'Regular User', '0987654321', 'user@example.com', 2);

-- Insert initial data into 'restaurant' table
INSERT INTO restaurant (name, branch, address, phone, email) VALUES
('Gourmet Place', 'Downtown', '123 Fine Dining Ave.', '111-222-3333', 'contact@gourmetplace.com'),
('Family Bites', 'Uptown', '456 Homely St.', '444-555-6666', 'info@familybites.com');

-- Insert initial data into 'table' table
-- Assuming restaurant_id 1 is Gourmet Place and 2 is Family Bites
INSERT INTO "table" (capacity, restaurant_id) VALUES
(4, 1), (2, 1), -- Tables for Gourmet Place
(6, 2), (4, 2); -- Tables for Family Bites

-- Insert initial data into 'reserve' table
-- Assuming user_id 2 is a regular user and table_id values from above
-- The timestamps are placeholders and should be replaced with actual reservation times
INSERT INTO reserve (start_time, end_time, date, user_id, table_id, status) VALUES
('2024-02-12 18:00:00', '2024-02-12 20:00:00', '2024-02-12', 2, 1, 'Confirmed'),
('2024-02-13 18:00:00', '2024-02-13 20:00:00', '2024-02-13', 2, 3, 'Confirmed');

-- Insert initial data into 'review' table
-- Assuming user_id 2 is a regular user and restaurant_id values from above
INSERT INTO review (description, user_id, restaurant_id) VALUES
('Great atmosphere and delicious food.', 2, 1),
('Perfect for family dinners. Loved it!', 2, 2);

-- Insert initial data into 'log' table
-- The timestamps are placeholders and should be replaced with actual log times
-- Assuming user_id 2 is a regular user
INSERT INTO log (type, date_time, user_id) VALUES
('login', '2024-02-12 17:00:00', 2),
('logout', '2024-02-12 21:00:00', 2);
