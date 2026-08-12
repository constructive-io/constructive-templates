-- Verify: schemas/routing_public/tables/http_routes/table


SELECT assert_table(CAST('routing_public.http_routes' AS regclass), false, NULL);