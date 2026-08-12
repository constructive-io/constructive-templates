-- Verify: schemas/routing_public/tables/sites/triggers/catalog_del


SELECT assert_trigger(CAST('routing_public.sites' AS regclass), 'catalog_del', CAST('catalog_private.tg_sites_catalog_del' AS regproc), 9);