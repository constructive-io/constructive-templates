-- Verify: schemas/routing_public/tables/platform_site_themes/indexes/platform_site_themes_created_at_idx


SELECT verify_index('routing_public.platform_site_themes', 'platform_site_themes_created_at_idx');