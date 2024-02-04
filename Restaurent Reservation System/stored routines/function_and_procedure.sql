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
    user_id INT;
BEGIN
    SELECT user_id INTO user_id FROM "user" WHERE username = uname AND password = passw;
    IF FOUND THEN
        -- Insert log for login
        INSERT INTO log (type, date_time, user_id) VALUES ('login', CURRENT_TIMESTAMP, user_id);
    ELSE
        RAISE EXCEPTION 'Invalid username or password.';
    END IF;
END;
$$;

-- Procedure for user logout
CREATE OR REPLACE PROCEDURE user_logout(uname VARCHAR)
LANGUAGE plpgsql AS $$
DECLARE
    user_id INT;
BEGIN
    SELECT user_id INTO user_id FROM "user" WHERE username = uname;
    IF FOUND THEN
        -- Insert log for logout
        INSERT INTO log (type, date_time, user_id) VALUES ('logout', CURRENT_TIMESTAMP, user_id);
    ELSE
        RAISE EXCEPTION 'Invalid username.';
    END IF;
END;
$$;
