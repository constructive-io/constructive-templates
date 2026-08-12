-- Verify: schemas/routing_public/tables/platform_site_themes/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.platform_site_themes' AS regclass), 'authenticated', 'DELETE', NULL, true);