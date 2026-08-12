-- Verify: schemas/routing_public/tables/platform_site_app_links/table


SELECT assert_table(CAST('routing_public.platform_site_app_links' AS regclass), false, NULL);