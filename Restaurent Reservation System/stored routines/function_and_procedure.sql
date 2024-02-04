-- Function to check if the username exists
CREATE OR REPLACE FUNCTION username_exists(uname VARCHAR)
RETURNS BOOLEAN AS $$
DECLARE
    user_count INT;
BEGIN
    SELECT COUNT(*) INTO user_count FROM "user" WHERE username = uname;
    RETURN user_count > 0;
END;
$$ LANGUAGE plpgsql;

-- Procedure for user registration
CREATE OR REPLACE PROCEDURE register_user(uname VARCHAR, passw VARCHAR, u_name VARCHAR, u_phone VARCHAR, u_email VARCHAR, u_role INT)
LANGUAGE plpgsql AS $$
BEGIN
    -- Check if username already exists
    IF username_exists(uname) THEN
        RAISE EXCEPTION 'Username already exists.';
    ELSE
        INSERT INTO "user" (username, password, name, phone, email, role_id)
        VALUES (uname, passw, u_name, u_phone, u_email, u_role);
    END IF;
END;
$$;

-- Procedure for user login
CREATE OR REPLACE PROCEDURE user_login(uname VARCHAR, passw VARCHAR)
LANGUAGE plpgsql AS $$
DECLARE
    found_user_id INT; -- Use a different variable name to avoid ambiguity
BEGIN
    SELECT user_id INTO found_user_id FROM "user" WHERE username = uname AND password = passw;
    IF FOUND THEN
        -- Insert log for login
        INSERT INTO log (type, date_time, user_id) VALUES ('login', CURRENT_TIMESTAMP, found_user_id);
    ELSE
        RAISE EXCEPTION 'Invalid username or password.';
    END IF;
END;
$$;


-- Procedure for user logout
CREATE OR REPLACE PROCEDURE user_logout(uname VARCHAR)
LANGUAGE plpgsql AS $$
DECLARE
    found_user_id INT;
BEGIN
    SELECT user_id INTO found_user_id FROM "user" WHERE username = uname;
    IF FOUND THEN
        -- Insert log for logout
        INSERT INTO log (type, date_time, user_id) VALUES ('logout', CURRENT_TIMESTAMP, found_user_id);
    ELSE
        RAISE EXCEPTION 'Invalid username.';
    END IF;
END;
$$;

-- Procedure for making a reservation
CREATE OR REPLACE PROCEDURE make_a_reservation(u_id INT, res_date DATE, res_start_time TIME, res_end_time TIME, selected_table_id INT)
LANGUAGE plpgsql AS $$
DECLARE
    reservation_count INT;
    existing_reservation_id INT;
BEGIN
    -- Check if the user has already made 3 reservations
    SELECT COUNT(*) INTO reservation_count FROM make_reservation WHERE user_id = u_id;
    IF reservation_count >= 3 THEN
        RAISE EXCEPTION 'User has already made 3 reservations.';
    END IF;

    -- Check if the table is available (no overlapping reservations)
    SELECT reservation_id INTO existing_reservation_id FROM reservation
    WHERE table_id = selected_table_id AND date = res_date AND NOT (
        res_start_time >= end_time OR
        res_end_time <= start_time
    );
    IF existing_reservation_id IS NOT NULL THEN
        RAISE EXCEPTION 'Table is not available at the specified time.';
    END IF;

    -- Insert new reservation
    INSERT INTO reservation (date, start_time, end_time, table_id)
    VALUES (res_date, res_start_time, res_end_time, selected_table_id) RETURNING reservation_id INTO reservation_count;

    -- Associate the reservation with the user
    INSERT INTO make_reservation (user_id, reservation_id)
    VALUES (u_id, reservation_count);
END;
$$;

-- Procedure for viewing a reservation
CREATE OR REPLACE FUNCTION view_reservation(u_id INT, res_id INT)
RETURNS TABLE(reservation_id INT, reservation_date DATE, start_time TIME, end_time TIME, table_capacity INT) AS $$
BEGIN
    RETURN QUERY SELECT r.reservation_id, r.date, r.start_time, r.end_time, t.capacity
    FROM reservation r
    JOIN "table" t ON r.table_id = t.table_id
    WHERE r.reservation_id = res_id AND EXISTS (
        SELECT 1 FROM make_reservation WHERE user_id = u_id AND reservation_id = res_id
    );
END;
$$ LANGUAGE plpgsql;

-- Procedure for editing a reservation
CREATE OR REPLACE PROCEDURE edit_reservation(res_id INT, new_date DATE, new_start_time TIME, new_end_time TIME, new_table_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    -- Update the reservation
    UPDATE reservation SET
    date = new_date,
    start_time = new_start_time,
    end_time = new_end_time,
    table_id = new_table_id
    WHERE reservation_id = res_id;
END;
$$;

-- Procedure for deleting a reservation
CREATE OR REPLACE PROCEDURE delete_reservation(u_id INT, res_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    -- Delete the association of the reservation with the user
    DELETE FROM make_reservation WHERE user_id = u_id AND reservation_id = res_id;

    -- Delete the reservation
    DELETE FROM reservation WHERE reservation_id = res_id;
END;
$$;

