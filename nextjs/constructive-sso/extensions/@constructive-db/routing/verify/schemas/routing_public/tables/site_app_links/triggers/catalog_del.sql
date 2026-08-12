-- Verify: schemas/routing_public/tables/site_app_links/triggers/catalog_del


SELECT assert_trigger(CAST('routing_public.site_app_links' AS regclass), 'catalog_del', CAST('catalog_private.tg_site_app_links_catalog_del' AS regproc), 9);