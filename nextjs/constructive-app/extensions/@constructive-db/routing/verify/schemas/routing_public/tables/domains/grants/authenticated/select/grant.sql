-- Verify: schemas/routing_public/tables/domains/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.domains' AS regclass), 'authenticated', 'SELECT', NULL, true);