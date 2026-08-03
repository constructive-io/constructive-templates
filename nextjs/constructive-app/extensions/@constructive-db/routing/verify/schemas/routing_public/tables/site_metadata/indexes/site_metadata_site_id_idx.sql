-- Verify: schemas/routing_public/tables/site_metadata/indexes/site_metadata_site_id_idx


SELECT verify_index('routing_public.site_metadata', 'site_metadata_site_id_idx');