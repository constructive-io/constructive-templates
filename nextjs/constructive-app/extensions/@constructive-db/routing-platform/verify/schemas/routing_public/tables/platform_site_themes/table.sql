-- Verify: schemas/routing_public/tables/platform_site_themes/table


SELECT assert_table(CAST('routing_public.platform_site_themes' AS regclass), false, NULL);