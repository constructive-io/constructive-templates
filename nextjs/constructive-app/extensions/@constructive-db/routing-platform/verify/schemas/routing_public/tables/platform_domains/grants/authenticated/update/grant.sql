-- Verify: schemas/routing_public/tables/platform_domains/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_domains' AS regclass), 'authenticated', 'UPDATE', NULL, true);