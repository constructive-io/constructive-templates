-- Verify: schemas/routing_public/tables/domains/indexes/domains_created_at_idx


SELECT verify_index('routing_public.domains', 'domains_created_at_idx');