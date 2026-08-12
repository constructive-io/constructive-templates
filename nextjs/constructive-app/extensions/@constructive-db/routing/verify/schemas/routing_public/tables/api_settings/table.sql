-- Verify: schemas/routing_public/tables/api_settings/table


SELECT assert_table(CAST('routing_public.api_settings' AS regclass), false, NULL);