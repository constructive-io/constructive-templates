-- Verify: schemas/routing_public/tables/platform_managed_domains/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_managed_domains' AS regclass), 'authenticated', 'UPDATE', NULL, true);