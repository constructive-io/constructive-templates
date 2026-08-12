-- Verify: schemas/routing_public/tables/rls_settings/table


SELECT assert_table(CAST('routing_public.rls_settings' AS regclass), false, NULL);