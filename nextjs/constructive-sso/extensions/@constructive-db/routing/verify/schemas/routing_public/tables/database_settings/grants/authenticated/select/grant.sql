-- Verify: schemas/routing_public/tables/database_settings/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.database_settings' AS regclass), 'authenticated', 'SELECT', NULL, true);