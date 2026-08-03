-- Verify: schemas/routing_public/tables/platform_apis/indexes/platform_apis_updated_at_idx


SELECT verify_index('routing_public.platform_apis', 'platform_apis_updated_at_idx');