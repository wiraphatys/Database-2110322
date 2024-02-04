-- Stored Function: Check reservation limit for a user
CREATE OR REPLACE FUNCTION check_reservation_limit(p_user_id INT) RETURNS BOOLEAN AS $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM reservations
    WHERE user_id = p_user_id
    AND reservation_date = CURRENT_DATE;

    RETURN v_count < 3;
END;
$$ LANGUAGE plpgsql;