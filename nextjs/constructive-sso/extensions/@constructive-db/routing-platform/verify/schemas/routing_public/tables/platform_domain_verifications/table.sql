-- Verify: schemas/routing_public/tables/platform_domain_verifications/table


SELECT assert_table(CAST('routing_public.platform_domain_verifications' AS regclass), false, NULL);