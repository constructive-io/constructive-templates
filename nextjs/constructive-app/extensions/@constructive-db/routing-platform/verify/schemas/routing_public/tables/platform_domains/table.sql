-- Verify: schemas/routing_public/tables/platform_domains/table


SELECT assert_table(CAST('routing_public.platform_domains' AS regclass), false, NULL);