-- Verify: schemas/routing_public/tables/platform_site_themes/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_site_themes' AS regclass), 'authenticated', 'UPDATE', NULL, true);