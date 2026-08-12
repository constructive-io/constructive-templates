-- Verify: schemas/catalog_private/trigger_fns/tg_platform_site_error_pages_catalog_sync


SELECT assert_function(CAST('catalog_private.tg_platform_site_error_pages_catalog_sync()' AS regprocedure), CAST('TRIGGER' AS regtype), false, true, 'VOLATILE');