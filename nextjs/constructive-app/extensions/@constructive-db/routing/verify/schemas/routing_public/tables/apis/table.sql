-- Verify: schemas/routing_public/tables/apis/table


SELECT assert_table(CAST('routing_public.apis' AS regclass), false, NULL);