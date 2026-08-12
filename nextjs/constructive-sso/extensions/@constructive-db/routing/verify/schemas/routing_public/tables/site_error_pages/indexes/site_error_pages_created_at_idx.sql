-- Verify: schemas/routing_public/tables/site_error_pages/indexes/site_error_pages_created_at_idx


SELECT assert_index(CAST('routing_public.site_error_pages_created_at_idx' AS regclass), CAST('routing_public.site_error_pages' AS regclass), false);