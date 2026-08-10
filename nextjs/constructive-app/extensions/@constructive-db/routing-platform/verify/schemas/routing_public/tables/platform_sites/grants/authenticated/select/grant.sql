-- Verify: schemas/routing_public/tables/platform_sites/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.platform_sites' AS regclass), 'authenticated', 'SELECT', NULL, true);