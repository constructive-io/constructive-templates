-- Verify: schemas/routing_public/tables/platform_site_metadata/indexes/platform_site_metadata_created_at_idx


SELECT assert_index(CAST('routing_public.platform_site_metadata_created_at_idx' AS regclass), CAST('routing_public.platform_site_metadata' AS regclass), false);