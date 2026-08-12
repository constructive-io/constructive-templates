-- Verify: schemas/routing_public/tables/sites/indexes/routing_public_sites_bucket_id_idx


SELECT assert_index(CAST('routing_public.routing_public_sites_bucket_id_idx' AS regclass), CAST('routing_public.sites' AS regclass), false);