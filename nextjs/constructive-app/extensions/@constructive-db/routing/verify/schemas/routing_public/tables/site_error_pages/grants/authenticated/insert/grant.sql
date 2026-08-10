-- Verify: schemas/routing_public/tables/site_error_pages/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.site_error_pages' AS regclass), 'authenticated', 'INSERT', NULL, true);