-- Verify: schemas/routing_public/tables/site_app_links/indexes/site_app_links_updated_at_idx


SELECT assert_index(CAST('routing_public.site_app_links_updated_at_idx' AS regclass), CAST('routing_public.site_app_links' AS regclass), false);