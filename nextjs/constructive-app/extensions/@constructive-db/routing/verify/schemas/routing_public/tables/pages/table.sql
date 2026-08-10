-- Verify: schemas/routing_public/tables/pages/table


SELECT assert_table(CAST('routing_public.pages' AS regclass), false, NULL);