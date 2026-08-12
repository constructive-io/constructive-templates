-- Verify: schemas/routing_public/tables/site_error_pages/table


SELECT assert_table(CAST('routing_public.site_error_pages' AS regclass), false, NULL);