-- Verify: schemas/routing_public/tables/site_modules/indexes/site_modules_updated_at_idx


SELECT verify_index('routing_public.site_modules', 'site_modules_updated_at_idx');