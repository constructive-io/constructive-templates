-- Verify: schemas/routing_public/tables/managed_domains/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.managed_domains' AS regclass), 'authenticated', 'UPDATE', NULL, true);