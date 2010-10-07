UPDATE parts 
SET created_at = DATE_SUB(created_at, INTERVAL 1 YEAR)
WHERE is_new_item != 1