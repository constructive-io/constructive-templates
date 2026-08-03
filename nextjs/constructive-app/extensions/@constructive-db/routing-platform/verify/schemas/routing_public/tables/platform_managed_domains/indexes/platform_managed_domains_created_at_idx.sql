-- Verify: schemas/routing_public/tables/platform_managed_domains/indexes/platform_managed_domains_created_at_idx


SELECT verify_index('routing_public.platform_managed_domains', 'platform_managed_domains_created_at_idx');