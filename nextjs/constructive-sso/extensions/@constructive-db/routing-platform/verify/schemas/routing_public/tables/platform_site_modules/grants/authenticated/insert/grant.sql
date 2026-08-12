-- Verify: schemas/routing_public/tables/platform_site_modules/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.platform_site_modules' AS regclass), 'authenticated', 'INSERT', NULL, true);