
CREATE OR REPLACE FUNCTION username_exists(uname VARCHAR)
RETURNS BOOLEAN AS $$
DECLARE
    user_count INT;
BEGIN
    SELECT COUNT(*) INTO user_count FROM "user" WHERE username = uname;
    RETURN user_count > 0;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE register_user(uname VARCHAR, passw VARCHAR, u_name VARCHAR, u_phone VARCHAR, u_email VARCHAR, u_role INT)
LANGUAGE plpgsql AS $$
BEGIN
    IF username_exists(uname) THEN
        RAISE EXCEPTION 'Username already exists.';
    ELSE
        INSERT INTO "user" (username, password, name, phone, email, role_id)
        VALUES (uname, passw, u_name, u_phone, u_email, u_role);
    END IF;
END;
$$;


CREATE OR REPLACE PROCEDURE user_login(uname VARCHAR, passw VARCHAR)
LANGUAGE plpgsql AS $$
DECLARE
    found_user_id INT;
BEGIN
    SELECT user_id INTO found_user_id FROM "user" WHERE username = uname AND password = passw;
    IF FOUND THEN
        INSERT INTO log (type, date_time, user_id) VALUES ('login', CURRENT_TIMESTAMP, found_user_id);
    ELSE
        RAISE EXCEPTION 'Invalid username or password.';
    END IF;
END;
$$;


CREATE OR REPLACE PROCEDURE user_logout(uname VARCHAR)
LANGUAGE plpgsql AS $$
DECLARE
    found_user_id INT;
BEGIN
    SELECT user_id INTO found_user_id FROM "user" WHERE username = uname;
    IF FOUND THEN
        INSERT INTO log (type, date_time, user_id) VALUES ('logout', CURRENT_TIMESTAMP, found_user_id);
    ELSE
        RAISE EXCEPTION 'Invalid username.';
    END IF;
END;
$$;


CREATE OR REPLACE PROCEDURE make_a_reservation(u_id INT, res_date DATE, res_start_time TIME, res_end_time TIME, selected_table_id INT, res_status VARCHAR)
LANGUAGE plpgsql AS $$
DECLARE
    full_start_time TIMESTAMP;
    full_end_time TIMESTAMP;
BEGIN
    full_start_time := res_date + res_start_time;
    full_end_time := res_date + res_end_time;

    INSERT INTO reserve (date, start_time, end_time, user_id, table_id, status)
    VALUES (res_date, full_start_time, full_end_time, u_id, selected_table_id, res_status);
END;
$$;


CREATE OR REPLACE FUNCTION view_reservation(u_id INT, requested_res_id INT)
RETURNS TABLE(reserve_id INT, reservation_date DATE, start_time TIME, end_time TIME, table_capacity INT) AS $$
BEGIN
    RETURN QUERY SELECT r.reserve_id, r.date, CAST(r.start_time AS TIME), CAST(r.end_time AS TIME), t.capacity
    FROM reserve r
    JOIN "table" t ON r.table_id = t.table_id
    WHERE r.reserve_id = requested_res_id AND r.user_id = u_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE edit_reservation(res_id INT, new_date DATE, new_start_time TIME, new_end_time TIME, new_table_id INT, new_status VARCHAR)
LANGUAGE plpgsql AS $$
DECLARE
    full_new_start_time TIMESTAMP;
    full_new_end_time TIMESTAMP;
BEGIN
    full_new_start_time := new_date + new_start_time; -- Combine new_date and new_start_time
    full_new_end_time := new_date + new_end_time;     -- Combine new_date and new_end_time

    UPDATE reserve SET
    date = new_date,
    start_time = full_new_start_time, -- Use full timestamp
    end_time = full_new_end_time,     -- Use full timestamp
    table_id = new_table_id,
    status = new_status
    WHERE reserve_id = res_id;
END;
$$;



CREATE OR REPLACE PROCEDURE delete_reservation(res_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM reserve WHERE reserve_id = res_id;
END;
$$;
