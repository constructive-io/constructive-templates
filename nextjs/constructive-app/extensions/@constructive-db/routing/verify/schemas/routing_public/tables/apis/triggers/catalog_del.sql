-- Verify: schemas/routing_public/tables/apis/triggers/catalog_del


SELECT assert_trigger(CAST('routing_public.apis' AS regclass), 'catalog_del', CAST('catalog_private.tg_apis_catalog_del' AS regproc), 9);