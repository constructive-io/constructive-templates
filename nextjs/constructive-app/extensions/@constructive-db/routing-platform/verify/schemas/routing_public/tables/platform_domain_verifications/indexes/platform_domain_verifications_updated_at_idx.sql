-- Verify: schemas/routing_public/tables/platform_domain_verifications/indexes/platform_domain_verifications_updated_at_idx


SELECT assert_index(CAST('routing_public.platform_domain_verifications_updated_at_idx' AS regclass), CAST('routing_public.platform_domain_verifications' AS regclass), false);