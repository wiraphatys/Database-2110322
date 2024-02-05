CREATE TABLE address_audit_log (
    old_address VARCHAR NOT NULL,
    exec_time TIMESTAMP NOT NULL
)

CREATE OR REPLACE FUNCTION log_address_history(location VARCHAR, updated_time TIMESTAMP)
RETURN TRIGGER
language plpgsql AS $$
BEGIN
    INSERT INTO address_audit_log VALUES(OLD.location, now());
    RETURN NEW;
END; $$

CREATE TRIGGER updating_new_address
BEFORE INSERT
ON customer
FOR EACH ROW
EXCUTE PROCEDURE log_address_history();