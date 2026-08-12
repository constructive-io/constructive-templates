-- Verify: schemas/routing_public/tables/sites/table


SELECT assert_table(CAST('routing_public.sites' AS regclass), false, NULL);