-- Verify: schemas/routing_public/tables/api_schemas/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.api_schemas' AS regclass), 'authenticated', 'SELECT', NULL, true);