-- Verify: schemas/routing_public/tables/platform_site_error_pages/indexes/platform_site_error_pages_updated_at_idx


SELECT assert_index(CAST('routing_public.platform_site_error_pages_updated_at_idx' AS regclass), CAST('routing_public.platform_site_error_pages' AS regclass), false);