-- Verify: schemas/routing_public/tables/platform_domain_verifications/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.platform_domain_verifications' AS regclass), 'authenticated', 'SELECT', NULL, true);