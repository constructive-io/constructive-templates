-- Verify: schemas/routing_public/tables/platform_site_web_configs/triggers/catalog_sync


SELECT assert_trigger(CAST('routing_public.platform_site_web_configs' AS regclass), 'catalog_sync', CAST('catalog_private.tg_platform_site_web_configs_catalog_sync' AS regproc), 21);