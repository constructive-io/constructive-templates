-- Verify: schemas/routing_public/tables/platform_site_app_links/indexes/platform_site_app_links_created_at_idx


SELECT assert_index(CAST('routing_public.platform_site_app_links_created_at_idx' AS regclass), CAST('routing_public.platform_site_app_links' AS regclass), false);