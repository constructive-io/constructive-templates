-- Verify: schemas/routing_public/tables/managed_domains/table


SELECT assert_table(CAST('routing_public.managed_domains' AS regclass), false, NULL);