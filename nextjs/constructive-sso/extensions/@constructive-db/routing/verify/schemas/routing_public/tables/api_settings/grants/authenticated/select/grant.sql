-- Verify: schemas/routing_public/tables/api_settings/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.api_settings' AS regclass), 'authenticated', 'SELECT', NULL, true);