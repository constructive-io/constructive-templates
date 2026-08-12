-- Verify: schemas/routing_public/tables/database_settings/table


SELECT assert_table(CAST('routing_public.database_settings' AS regclass), false, NULL);