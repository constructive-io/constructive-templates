-- Verify: schemas/routing_public/tables/platform_site_modules/indexes/platform_site_modules_created_at_idx


SELECT verify_index('routing_public.platform_site_modules', 'platform_site_modules_created_at_idx');