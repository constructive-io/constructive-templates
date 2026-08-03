-- Verify: schemas/routing_public/tables/managed_domains/indexes/managed_domains_created_at_idx


SELECT verify_index('routing_public.managed_domains', 'managed_domains_created_at_idx');