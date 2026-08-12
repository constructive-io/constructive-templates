-- Verify: schemas/catalog_private/tables/apps/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.apps' AS regclass), 'authenticated', 'DELETE', NULL, true);