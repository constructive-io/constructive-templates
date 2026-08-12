-- Verify: schemas/routing_public/tables/platform_sites/indexes/platform_sites_updated_at_idx


SELECT assert_index(CAST('routing_public.platform_sites_updated_at_idx' AS regclass), CAST('routing_public.platform_sites' AS regclass), false);