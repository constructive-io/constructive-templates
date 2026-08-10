-- Verify: schemas/catalog_private/tables/resources/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.resources' AS regclass), 'authenticated', 'UPDATE', NULL, true);