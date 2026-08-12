-- Verify: schemas/routing_public/tables/cors_settings/table


SELECT assert_table(CAST('routing_public.cors_settings' AS regclass), false, NULL);