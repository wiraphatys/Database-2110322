CREATE FUNCTION get_branches_assets_greater_than(con float)
RETURNS TABLE (
	branch_name VARCHAR,
	branch_city VARCHAR,
	assets FLOAT
)
LANGUAGE plpgsql
AS
$$
BEGIN
	RETURN query
	SELECT Branch_name , Branch_city , assets FROM branch
	WHERE assets > con
	ORDER BY Branch_name ASC;
END;
$$