-- Verify: schemas/routing_public/tables/site_app_links/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.site_app_links' AS regclass), 'authenticated', 'INSERT', NULL, true);