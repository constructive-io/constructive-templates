-- Verify: schemas/catalog_private/tables/sites_error_pages/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('catalog_private.sites_error_pages' AS regclass), 'authenticated', 'DELETE', NULL, true);