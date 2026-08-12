-- Verify: schemas/routing_public/tables/platform_site_deep_links/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.platform_site_deep_links' AS regclass), 'authenticated', 'SELECT', NULL, true);