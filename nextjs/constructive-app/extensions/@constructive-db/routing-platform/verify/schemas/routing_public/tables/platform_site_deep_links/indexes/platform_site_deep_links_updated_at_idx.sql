-- Verify: schemas/routing_public/tables/platform_site_deep_links/indexes/platform_site_deep_links_updated_at_idx


SELECT assert_index(CAST('routing_public.platform_site_deep_links_updated_at_idx' AS regclass), CAST('routing_public.platform_site_deep_links' AS regclass), false);