-- Verify: schemas/routing_public/tables/platform_domains/triggers/catalog_del


SELECT assert_trigger(CAST('routing_public.platform_domains' AS regclass), 'catalog_del', CAST('catalog_private.tg_platform_domains_catalog_del' AS regproc), 9);