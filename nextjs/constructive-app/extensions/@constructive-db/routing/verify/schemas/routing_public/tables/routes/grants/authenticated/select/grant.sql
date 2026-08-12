-- Verify: schemas/routing_public/tables/routes/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.routes' AS regclass), 'authenticated', 'SELECT', NULL, true);