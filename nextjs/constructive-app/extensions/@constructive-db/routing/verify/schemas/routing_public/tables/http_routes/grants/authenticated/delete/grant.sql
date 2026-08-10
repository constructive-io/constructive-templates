-- Verify: schemas/routing_public/tables/http_routes/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.http_routes' AS regclass), 'authenticated', 'DELETE', NULL, true);