-- Verify: schemas/catalog_private/tables/domains/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('catalog_private.domains' AS regclass), 'authenticated', 'UPDATE', NULL, true);