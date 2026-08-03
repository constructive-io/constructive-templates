-- Verify: schemas/routing_public/tables/sites/indexes/sites_created_at_idx


SELECT verify_index('routing_public.sites', 'sites_created_at_idx');