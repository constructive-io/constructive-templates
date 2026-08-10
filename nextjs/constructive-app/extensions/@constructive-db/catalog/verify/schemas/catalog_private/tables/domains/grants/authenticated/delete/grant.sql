-- Verify: schemas/catalog_private/tables/domains/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.domains' AS regclass), 'authenticated', 'DELETE', NULL, true);