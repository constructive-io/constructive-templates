-- Verify: schemas/routing_public/tables/http_routes/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.http_routes' AS regclass), 'authenticated', 'SELECT', NULL, true);