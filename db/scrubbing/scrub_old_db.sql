DROP TABLE assemblies;
DROP TABLE assembly_parts;
DROP TABLE `product_lines_BAK_2007-08-08`;

/* -- PRODUCT LINES -- */
SELECT *
FROM parts
WHERE product_line NOT IN (SELECT id FROM product_lines);

DELETE FROM parts
WHERE product_line NOT IN (SELECT id FROM product_lines);

/* -- PARTS FEATURED -- */
SELECT *
FROM parts_featured
WHERE part_id NOT IN (SELECT id FROM parts);

DELETE FROM parts_featured
WHERE part_id NOT IN (SELECT id FROM parts);

SELECT *
FROM parts_featured
WHERE product_line_id NOT IN (SELECT id FROM product_lines);

DELETE FROM parts_featured
WHERE product_line_id NOT IN (SELECT id FROM product_lines);

/* -- UNITS -- */
SELECT *
FROM units
WHERE product_line NOT IN (SELECT id FROM product_lines);

DELETE FROM units
WHERE product_line NOT IN (SELECT id FROM product_lines);

SELECT *
FROM units
WHERE ref_figure_id NOT IN (SELECT id FROM ref_figures);

UPDATE units
SET ref_figure_id = NULL WHERE ref_figure_id NOT IN (SELECT id FROM ref_figures);

/* -- UNIT MAKES -- */
SELECT *
FROM unit_makes
WHERE unit_id NOT IN (SELECT id FROM units);

DELETE
FROM unit_makes
WHERE unit_id NOT IN (SELECT id FROM units);

SELECT *
FROM unit_makes
WHERE make_id NOT IN (SELECT id FROM makes);

DELETE
FROM unit_makes
WHERE make_id NOT IN (SELECT id FROM makes);

/* -- UNIT COMPONENTS -- */
SELECT *
FROM unit_components
WHERE assembly_or_part_id NOT IN (SELECT id FROM parts) AND component_type = '0';

DELETE
FROM unit_components
WHERE assembly_or_part_id NOT IN (SELECT id FROM parts) AND component_type = '0';
