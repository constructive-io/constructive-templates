-- Verify: schemas/routing_public/tables/platform_site_error_pages/table


SELECT assert_table(CAST('routing_public.platform_site_error_pages' AS regclass), false, NULL);