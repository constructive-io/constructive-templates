-- Verify: schemas/routing_public/tables/domains/triggers/catalog_del


SELECT assert_trigger(CAST('routing_public.domains' AS regclass), 'catalog_del', CAST('catalog_private.tg_domains_catalog_del' AS regproc), 9);