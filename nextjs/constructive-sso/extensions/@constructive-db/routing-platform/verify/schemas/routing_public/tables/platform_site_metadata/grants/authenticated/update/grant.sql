-- Verify: schemas/routing_public/tables/platform_site_metadata/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_site_metadata' AS regclass), 'authenticated', 'UPDATE', NULL, true);