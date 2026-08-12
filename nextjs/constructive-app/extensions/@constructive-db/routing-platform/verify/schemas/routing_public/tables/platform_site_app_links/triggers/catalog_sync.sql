-- Verify: schemas/routing_public/tables/platform_site_app_links/triggers/catalog_sync


SELECT assert_trigger(CAST('routing_public.platform_site_app_links' AS regclass), 'catalog_sync', CAST('catalog_private.tg_platform_site_app_links_catalog_sync' AS regproc), 21);