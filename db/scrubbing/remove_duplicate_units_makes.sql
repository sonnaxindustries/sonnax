SELECT *
FROM units_makes um, units_makes um2
WHERE um.unit_id = um2.unit_id AND um.make_id = um2.make_id AND um.id <> um2.id

