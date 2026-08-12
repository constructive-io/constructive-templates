-- Verify: schemas/routing_public/tables/platform_domains/indexes/platform_domains_created_at_idx


SELECT verify_index('routing_public.platform_domains', 'platform_domains_created_at_idx');