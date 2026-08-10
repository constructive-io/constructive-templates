-- Verify: schemas/routing_public/tables/platform_site_metadata/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.platform_site_metadata' AS regclass), 'authenticated', 'INSERT', NULL, true);