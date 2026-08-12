-- Verify: schemas/routing_public/tables/platform_sites/indexes/platform_sites_created_at_idx


SELECT verify_index('routing_public.platform_sites', 'platform_sites_created_at_idx');