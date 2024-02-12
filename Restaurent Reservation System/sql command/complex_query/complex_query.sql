SELECT *
FROM (
    SELECT R.restaurant_id, R.branch, SUM(T.capacity) AS total_customer, DENSE_RANK() OVER(ORDER BY SUM(T.capacity) DESC) AS rank
    FROM restaurant R
    JOIN "table" T ON R.restaurant_id = T.restaurant_id
    JOIN (
        SELECT reserve_id, table_id
        FROM reserve
        WHERE date = CURRENT_DATE AND start_time::time BETWEEN '11:00:00' AND '14:00:00'
    ) Re ON Re.table_id = T.table_id
    GROUP BY R.restaurant_id, R.branch
) AS RankedRestaurants
WHERE rank = 2;
