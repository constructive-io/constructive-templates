-- Verify: schemas/routing_public/tables/platform_managed_domains/table


SELECT assert_table(CAST('routing_public.platform_managed_domains' AS regclass), false, NULL);