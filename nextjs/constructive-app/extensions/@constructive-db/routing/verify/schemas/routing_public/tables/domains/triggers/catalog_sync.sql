-- Verify: schemas/routing_public/tables/domains/triggers/catalog_sync


SELECT assert_trigger(CAST('routing_public.domains' AS regclass), 'catalog_sync', CAST('catalog_private.tg_domains_catalog_sync' AS regproc), 21);