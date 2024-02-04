-- Trigger Function: Log user actions
CREATE OR REPLACE FUNCTION log_user_action() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO logs (user_id, action_type, action_date_time)
    VALUES (NEW.user_id, TG_ARGV[0], CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for logging user actions
CREATE TRIGGER after_user_action
AFTER INSERT OR UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION log_user_action(TG_ARGV[0]);