-- Verify: schemas/catalog_private/tables/domains/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.domains' AS regclass), 'authenticated', 'INSERT', NULL, true);