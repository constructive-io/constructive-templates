-- Verify: schemas/catalog_private/tables/apps/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.apps' AS regclass), 'authenticated', 'UPDATE', NULL, true);