-- Verify: schemas/routing_public/tables/platform_site_modules/table


SELECT assert_table(CAST('routing_public.platform_site_modules' AS regclass), false, NULL);