-- Verify: schemas/routing_public/tables/platform_site_metadata/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.platform_site_metadata' AS regclass), 'authenticated', 'SELECT', NULL, true);