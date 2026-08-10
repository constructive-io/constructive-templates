-- Verify: schemas/routing_public/tables/site_web_configs/triggers/catalog_sync


SELECT assert_trigger(CAST('routing_public.site_web_configs' AS regclass), 'catalog_sync', CAST('catalog_private.tg_site_web_configs_catalog_sync' AS regproc), 21);