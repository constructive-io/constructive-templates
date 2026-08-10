-- Verify: schemas/routing_public/tables/platform_site_app_links/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.platform_site_app_links' AS regclass), 'authenticated', 'DELETE', NULL, true);