-- Verify: schemas/routing_public/tables/site_error_pages/triggers/catalog_sync


SELECT assert_trigger(CAST('routing_public.site_error_pages' AS regclass), 'catalog_sync', CAST('catalog_private.tg_site_error_pages_catalog_sync' AS regproc), 21);