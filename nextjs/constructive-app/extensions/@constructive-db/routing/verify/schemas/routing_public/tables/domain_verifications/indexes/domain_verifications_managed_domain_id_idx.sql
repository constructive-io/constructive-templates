-- Verify: schemas/routing_public/tables/domain_verifications/indexes/domain_verifications_managed_domain_id_idx


SELECT assert_index(CAST('routing_public.domain_verifications_managed_domain_id_idx' AS regclass), CAST('routing_public.domain_verifications' AS regclass), false);