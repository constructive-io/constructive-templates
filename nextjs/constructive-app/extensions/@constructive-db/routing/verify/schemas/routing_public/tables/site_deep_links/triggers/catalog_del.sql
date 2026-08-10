-- Verify: schemas/routing_public/tables/site_deep_links/triggers/catalog_del


SELECT assert_trigger(CAST('routing_public.site_deep_links' AS regclass), 'catalog_del', CAST('catalog_private.tg_site_deep_links_catalog_del' AS regproc), 9);