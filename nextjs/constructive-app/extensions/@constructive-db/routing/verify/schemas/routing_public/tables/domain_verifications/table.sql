-- Verify: schemas/routing_public/tables/domain_verifications/table


SELECT assert_table(CAST('routing_public.domain_verifications' AS regclass), false, NULL);