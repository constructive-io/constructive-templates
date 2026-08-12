-- Verify: schemas/routing_public/tables/platform_apis/triggers/catalog_del


SELECT assert_trigger(CAST('routing_public.platform_apis' AS regclass), 'catalog_del', CAST('catalog_private.tg_platform_apis_catalog_del' AS regproc), 9);