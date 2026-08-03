-- Verify: schemas/routing_public/tables/platform_site_metadata/indexes/platform_site_metadata_created_at_idx


SELECT verify_index('routing_public.platform_site_metadata', 'platform_site_metadata_created_at_idx');