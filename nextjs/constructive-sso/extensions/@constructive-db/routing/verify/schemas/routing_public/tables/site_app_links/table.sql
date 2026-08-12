-- Verify: schemas/routing_public/tables/site_app_links/table


SELECT assert_table(CAST('routing_public.site_app_links' AS regclass), false, NULL);