-- Verify: schemas/routing_public/tables/routes/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.routes' AS regclass), 'authenticated', 'UPDATE', NULL, true);