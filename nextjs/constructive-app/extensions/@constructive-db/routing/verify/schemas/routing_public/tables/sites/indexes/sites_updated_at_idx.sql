-- Verify: schemas/routing_public/tables/sites/indexes/sites_updated_at_idx


SELECT verify_index('routing_public.sites', 'sites_updated_at_idx');