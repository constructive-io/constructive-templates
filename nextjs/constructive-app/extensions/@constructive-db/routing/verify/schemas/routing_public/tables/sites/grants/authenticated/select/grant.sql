-- Verify: schemas/routing_public/tables/sites/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.sites' AS regclass), 'authenticated', 'SELECT', NULL, true);