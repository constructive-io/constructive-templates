-- Verify: schemas/routing_public/tables/platform_domains/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.platform_domains' AS regclass), 'authenticated', 'SELECT', NULL, true);