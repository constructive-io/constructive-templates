-- Verify: schemas/routing_public/tables/platform_sites/triggers/catalog_del


SELECT assert_trigger(CAST('routing_public.platform_sites' AS regclass), 'catalog_del', CAST('catalog_private.tg_platform_sites_catalog_del' AS regproc), 9);