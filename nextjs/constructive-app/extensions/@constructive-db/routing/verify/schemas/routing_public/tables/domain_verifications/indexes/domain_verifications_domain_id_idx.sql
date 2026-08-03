-- Verify: schemas/routing_public/tables/domain_verifications/indexes/domain_verifications_domain_id_idx


SELECT verify_index('routing_public.domain_verifications', 'domain_verifications_domain_id_idx');