-- Verify: schemas/routing_public/tables/platform_site_modules/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_site_modules' AS regclass), 'authenticated', 'UPDATE', NULL, true);