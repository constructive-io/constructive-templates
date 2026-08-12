-- Verify: schemas/routing_public/tables/routes/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.routes' AS regclass), 'authenticated', 'DELETE', NULL, true);