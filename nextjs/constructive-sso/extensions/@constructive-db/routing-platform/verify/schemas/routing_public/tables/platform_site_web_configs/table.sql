-- Verify: schemas/routing_public/tables/platform_site_web_configs/table


SELECT assert_table(CAST('routing_public.platform_site_web_configs' AS regclass), false, NULL);