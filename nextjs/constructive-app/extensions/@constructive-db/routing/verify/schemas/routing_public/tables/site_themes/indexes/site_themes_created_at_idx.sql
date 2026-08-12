-- Verify: schemas/routing_public/tables/site_themes/indexes/site_themes_created_at_idx


SELECT assert_index(CAST('routing_public.site_themes_created_at_idx' AS regclass), CAST('routing_public.site_themes' AS regclass), false);