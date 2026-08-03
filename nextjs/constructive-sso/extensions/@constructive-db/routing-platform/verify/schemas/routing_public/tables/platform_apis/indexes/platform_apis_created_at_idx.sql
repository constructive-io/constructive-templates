-- Verify: schemas/routing_public/tables/platform_apis/indexes/platform_apis_created_at_idx


SELECT verify_index('routing_public.platform_apis', 'platform_apis_created_at_idx');