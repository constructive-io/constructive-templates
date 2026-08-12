-- Verify: schemas/routing_public/tables/pages/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.pages' AS regclass), 'authenticated', 'SELECT', NULL, true);