-- Verify: schemas/routing_public/tables/apis/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.apis' AS regclass), 'authenticated', 'SELECT', NULL, true);