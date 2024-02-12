INSERT INTO "user" (username, password, name, phone, email, role_id) VALUES
('user2', 'pass2', 'User Two', '1112223344', 'user2@example.com', 2),
('user3', 'pass3', 'User Three', '2223334455', 'user3@example.com', 2),
('user4', 'pass4', 'User Four', '3334445566', 'user4@example.com', 2),
('user5', 'pass5', 'User Five', '4445556677', 'user5@example.com', 2);

INSERT INTO "table" (capacity, restaurant_id) VALUES
(2, 1), (4, 1), (2, 2), (4, 2),
(2, 1), (4, 1), (2, 2), (4, 2);

INSERT INTO reserve (start_time, end_time, date, user_id, table_id, status) VALUES
('2024-02-18 18:00:00', '2024-02-18 20:00:00', '2024-02-18', 2, 5, 'Confirmed'),
('2024-02-19 19:00:00', '2024-02-19 21:00:00', '2024-02-19', 3, 6, 'Confirmed'),
('2024-02-20 18:00:00', '2024-02-20 20:00:00', '2024-02-20', 4, 7, 'Confirmed'),
('2024-02-21 19:00:00', '2024-02-21 21:00:00', '2024-02-21', 5, 8, 'Confirmed');

INSERT INTO review (description, user_id, restaurant_id) VALUES
('Fantastic service and food!', 2, 1),
('Could not have asked for a better evening.', 3, 1),
('Truly a gem of a place. Highly recommend.', 4, 2),
('Loved the ambiance and the menu options.', 5, 2);

INSERT INTO reserve (start_time, end_time, date, user_id, table_id, status) VALUES
(CURRENT_TIMESTAMP + INTERVAL '1 hour', CURRENT_TIMESTAMP + INTERVAL '3 hours', CURRENT_DATE, 2, 1, 'Confirmed'),
(CURRENT_TIMESTAMP + INTERVAL '2 hours', CURRENT_TIMESTAMP + INTERVAL '4 hours', CURRENT_DATE, 3, 2, 'Confirmed'),
(CURRENT_TIMESTAMP + INTERVAL '1 hour', CURRENT_TIMESTAMP + INTERVAL '3 hours', CURRENT_DATE, 4, 3, 'Confirmed'),
(CURRENT_TIMESTAMP + INTERVAL '2 hours', CURRENT_TIMESTAMP + INTERVAL '4 hours', CURRENT_DATE, 5, 4, 'Confirmed'),
(CURRENT_TIMESTAMP + INTERVAL '1 hour', CURRENT_TIMESTAMP + INTERVAL '3 hours', CURRENT_DATE, 2, 5, 'Confirmed'),
(CURRENT_TIMESTAMP + INTERVAL '2 hours', CURRENT_TIMESTAMP + INTERVAL '4 hours', CURRENT_DATE, 3, 6, 'Confirmed'),
(CURRENT_TIMESTAMP + INTERVAL '1 hour', CURRENT_TIMESTAMP + INTERVAL '3 hours', CURRENT_DATE, 4, 7, 'Confirmed'),
(CURRENT_TIMESTAMP + INTERVAL '2 hours', CURRENT_TIMESTAMP + INTERVAL '4 hours', CURRENT_DATE, 5, 8, 'Confirmed');
