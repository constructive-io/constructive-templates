-- Verify: schemas/routing_public/tables/site_app_links/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.site_app_links' AS regclass), 'authenticated', 'UPDATE', NULL, true);