-- Verify: schemas/routing_public/tables/platform_site_metadata/table


SELECT assert_table(CAST('routing_public.platform_site_metadata' AS regclass), false, NULL);