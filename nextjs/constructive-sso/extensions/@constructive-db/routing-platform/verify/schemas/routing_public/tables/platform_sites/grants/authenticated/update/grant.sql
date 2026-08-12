-- Verify: schemas/routing_public/tables/platform_sites/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_sites' AS regclass), 'authenticated', 'UPDATE', NULL, true);