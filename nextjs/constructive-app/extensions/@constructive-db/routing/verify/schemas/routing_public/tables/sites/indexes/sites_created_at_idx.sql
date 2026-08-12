-- Verify: schemas/routing_public/tables/sites/indexes/sites_created_at_idx


SELECT assert_index(CAST('routing_public.sites_created_at_idx' AS regclass), CAST('routing_public.sites' AS regclass), false);