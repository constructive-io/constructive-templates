-- Verify: schemas/routing_public/tables/platform_apis/indexes/platform_apis_updated_at_idx


SELECT assert_index(CAST('routing_public.platform_apis_updated_at_idx' AS regclass), CAST('routing_public.platform_apis' AS regclass), false);