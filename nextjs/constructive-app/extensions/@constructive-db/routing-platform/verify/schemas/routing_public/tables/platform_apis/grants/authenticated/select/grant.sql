-- Verify: schemas/routing_public/tables/platform_apis/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.platform_apis' AS regclass), 'authenticated', 'SELECT', NULL, true);