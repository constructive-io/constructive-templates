-- Verify: schemas/routing_public/tables/route_bindings/table


SELECT assert_table(CAST('routing_public.route_bindings' AS regclass), false, NULL);