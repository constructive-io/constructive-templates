-- Verify: schemas/routing_public/tables/site_deep_links/indexes/site_deep_links_created_at_idx


SELECT assert_index(CAST('routing_public.site_deep_links_created_at_idx' AS regclass), CAST('routing_public.site_deep_links' AS regclass), false);