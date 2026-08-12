-- Verify: schemas/routing_public/tables/platform_sites/indexes/platform_sites_resource_id_idx


SELECT assert_index(CAST('routing_public.platform_sites_resource_id_idx' AS regclass), CAST('routing_public.platform_sites' AS regclass), false);