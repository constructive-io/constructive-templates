-- Verify: schemas/routing_public/tables/platform_site_themes/indexes/platform_site_themes_updated_at_idx


SELECT assert_index(CAST('routing_public.platform_site_themes_updated_at_idx' AS regclass), CAST('routing_public.platform_site_themes' AS regclass), false);