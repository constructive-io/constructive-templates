-- Verify: schemas/routing_public/tables/cors_settings/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.cors_settings' AS regclass), 'authenticated', 'SELECT', NULL, true);