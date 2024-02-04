-- Stored Procedure: Insert new reservation
CREATE OR REPLACE PROCEDURE insert_reservation(p_user_id INT, p_restaurant_id INT, p_reservation_date DATE, p_reservation_time TIME, p_table_count INT) AS $$
BEGIN
    IF check_reservation_limit(p_user_id) THEN
        INSERT INTO reservations (user_id, restaurant_id, reservation_date, reservation_time, table_count)
        VALUES (p_user_id, p_restaurant_id, p_reservation_date, p_reservation_time, p_table_count);
    ELSE
        RAISE EXCEPTION 'User has reached the reservation limit for today.';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Stored Procedure: Update an existing reservation
CREATE OR REPLACE PROCEDURE update_reservation(p_reservation_id INT, p_user_id INT, p_restaurant_id INT, p_reservation_date DATE, p_reservation_time TIME, p_table_count INT) AS $$
BEGIN
    IF check_reservation_limit(p_user_id) THEN
        UPDATE reservations
        SET restaurant_id = p_restaurant_id,
            reservation_date = p_reservation_date,
            reservation_time = p_reservation_time,
            table_count = p_table_count
        WHERE reservation_id = p_reservation_id;
    ELSE
        RAISE EXCEPTION 'User has reached the reservation limit for today.';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Stored Procedure: Delete an existing reservation
CREATE OR REPLACE PROCEDURE delete_reservation(p_reservation_id INT) AS $$
BEGIN
    DELETE FROM reservations
    WHERE reservation_id = p_reservation_id;
END;
$$ LANGUAGE plpgsql;

-- Stored Procedure: User Login
CREATE OR REPLACE PROCEDURE user_login(p_email VARCHAR(255), p_password VARCHAR(255), OUT p_is_authenticated BOOLEAN) AS $$
BEGIN
    -- Initialize the output parameter
    p_is_authenticated := FALSE;

    -- Check if the email and hashed password match an entry in the users table.
    SELECT EXISTS (
        SELECT 1 FROM users WHERE email = p_email AND password = crypt(p_password, password)
    ) INTO p_is_authenticated;

    -- If the credentials match, the user is authenticated.
END;
$$ LANGUAGE plpgsql;