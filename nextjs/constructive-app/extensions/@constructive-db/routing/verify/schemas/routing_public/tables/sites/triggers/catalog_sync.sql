-- Verify: schemas/routing_public/tables/sites/triggers/catalog_sync


SELECT assert_trigger(CAST('routing_public.sites' AS regclass), 'catalog_sync', CAST('catalog_private.tg_sites_catalog_sync' AS regproc), 21);