-- Verify: schemas/catalog_private/tables/resources/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.resources' AS regclass), 'authenticated', 'INSERT', NULL, true);