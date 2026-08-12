-- Verify: schemas/routing_public/tables/platform_sites/table


SELECT assert_table(CAST('routing_public.platform_sites' AS regclass), false, NULL);