-- Verify: schemas/routing_public/tables/platform_domains/triggers/catalog_sync


SELECT assert_trigger(CAST('routing_public.platform_domains' AS regclass), 'catalog_sync', CAST('catalog_private.tg_platform_domains_catalog_sync' AS regproc), 21);