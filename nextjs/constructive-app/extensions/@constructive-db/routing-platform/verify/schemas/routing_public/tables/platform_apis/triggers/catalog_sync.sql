-- Verify: schemas/routing_public/tables/platform_apis/triggers/catalog_sync


SELECT assert_trigger(CAST('routing_public.platform_apis' AS regclass), 'catalog_sync', CAST('catalog_private.tg_platform_apis_catalog_sync' AS regproc), 21);