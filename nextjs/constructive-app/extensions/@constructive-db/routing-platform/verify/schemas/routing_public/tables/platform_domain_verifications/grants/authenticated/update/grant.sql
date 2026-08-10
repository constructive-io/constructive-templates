-- Verify: schemas/routing_public/tables/platform_domain_verifications/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_domain_verifications' AS regclass), 'authenticated', 'UPDATE', NULL, true);