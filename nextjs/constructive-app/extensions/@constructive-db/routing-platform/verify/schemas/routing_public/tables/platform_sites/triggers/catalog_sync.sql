-- Verify: schemas/routing_public/tables/platform_sites/triggers/catalog_sync


SELECT assert_trigger(CAST('routing_public.platform_sites' AS regclass), 'catalog_sync', CAST('catalog_private.tg_platform_sites_catalog_sync' AS regproc), 21);