-- Verify: schemas/routing_public/tables/platform_site_modules/indexes/platform_site_modules_updated_at_idx


SELECT assert_index(CAST('routing_public.platform_site_modules_updated_at_idx' AS regclass), CAST('routing_public.platform_site_modules' AS regclass), false);