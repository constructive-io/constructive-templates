-- Verify: schemas/routing_public/tables/platform_managed_domains/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.platform_managed_domains' AS regclass), 'authenticated', 'SELECT', NULL, true);