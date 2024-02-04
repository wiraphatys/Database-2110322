-- Trigger function for logging login actions
CREATE OR REPLACE FUNCTION log_login()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log (type, date_time, user_id) VALUES ('login', CURRENT_TIMESTAMP, NEW.user_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for login
CREATE TRIGGER trigger_log_login
AFTER INSERT ON "user"
FOR EACH ROW
EXECUTE FUNCTION log_login();

-- Trigger function for logging logout actions
CREATE OR REPLACE FUNCTION log_logout()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log (type, date_time, user_id) VALUES ('logout', CURRENT_TIMESTAMP, NEW.user_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for logout
CREATE TRIGGER trigger_log_logout
AFTER DELETE ON "user"
FOR EACH ROW
EXECUTE FUNCTION log_logout();
