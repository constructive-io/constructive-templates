-- Verify: schemas/routing_public/tables/apis/triggers/catalog_sync


SELECT assert_trigger(CAST('routing_public.apis' AS regclass), 'catalog_sync', CAST('catalog_private.tg_apis_catalog_sync' AS regproc), 21);