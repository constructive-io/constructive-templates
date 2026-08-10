-- Verify: schemas/catalog_private/tables/sites_error_pages/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('catalog_private.sites_error_pages' AS regclass), 'authenticated', 'INSERT', NULL, true);