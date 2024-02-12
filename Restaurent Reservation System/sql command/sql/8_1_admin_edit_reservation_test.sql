UPDATE reserve SET
    date = '2024-02-17', -- New date
    start_time = '2024-02-17 19:00:00', -- New start time as timestamp
    end_time = '2024-02-17 21:00:00', -- New end time as timestamp
    table_id = 3, -- New table_id, assuming it exists
    status = 'Confirmed' -- New status
WHERE reserve_id = 2;