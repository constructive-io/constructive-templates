-- Verify: schemas/routing_public/tables/domains/table


SELECT assert_table(CAST('routing_public.domains' AS regclass), false, NULL);