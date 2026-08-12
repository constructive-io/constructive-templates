-- Verify: schemas/routing_public/tables/site_metadata/indexes/site_metadata_database_id_idx


SELECT assert_index(CAST('routing_public.site_metadata_database_id_idx' AS regclass), CAST('routing_public.site_metadata' AS regclass), false);