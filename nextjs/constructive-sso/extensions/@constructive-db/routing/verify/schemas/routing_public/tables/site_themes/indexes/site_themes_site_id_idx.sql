-- Verify: schemas/routing_public/tables/site_themes/indexes/site_themes_site_id_idx


SELECT verify_index('routing_public.site_themes', 'site_themes_site_id_idx');