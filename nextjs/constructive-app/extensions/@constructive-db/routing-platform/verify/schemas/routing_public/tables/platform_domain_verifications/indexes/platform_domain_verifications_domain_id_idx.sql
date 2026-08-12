-- Verify: schemas/routing_public/tables/platform_domain_verifications/indexes/platform_domain_verifications_domain_id_idx


SELECT assert_index(CAST('routing_public.platform_domain_verifications_domain_id_idx' AS regclass), CAST('routing_public.platform_domain_verifications' AS regclass), false);