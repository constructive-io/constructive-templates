-- Verify: schemas/routing_public/tables/domain_verifications/indexes/domain_verifications_updated_at_idx


SELECT assert_index(CAST('routing_public.domain_verifications_updated_at_idx' AS regclass), CAST('routing_public.domain_verifications' AS regclass), false);