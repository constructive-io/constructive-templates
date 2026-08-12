-- Verify: schemas/routing_public/tables/managed_domains/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.managed_domains' AS regclass), 'authenticated', 'SELECT', NULL, true);