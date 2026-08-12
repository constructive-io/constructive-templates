-- Verify: schemas/routing_public/tables/domain_verifications/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.domain_verifications' AS regclass), 'authenticated', 'UPDATE', NULL, true);