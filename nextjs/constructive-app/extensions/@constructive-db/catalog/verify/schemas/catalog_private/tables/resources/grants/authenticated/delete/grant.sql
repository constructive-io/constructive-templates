-- Verify: schemas/catalog_private/tables/resources/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.resources' AS regclass), 'authenticated', 'DELETE', NULL, true);