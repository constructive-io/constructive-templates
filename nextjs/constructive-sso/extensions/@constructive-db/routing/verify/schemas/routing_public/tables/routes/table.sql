-- Verify: schemas/routing_public/tables/routes/table


SELECT assert_table(CAST('routing_public.routes' AS regclass), false, NULL);