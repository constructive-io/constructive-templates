-- Verify: schemas/routing_public/tables/hostname_bindings/table


SELECT assert_table(CAST('routing_public.hostname_bindings' AS regclass), false, NULL);