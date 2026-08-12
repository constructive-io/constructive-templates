-- Verify: schemas/routing_public/tables/routes/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.routes' AS regclass), 'authenticated', 'INSERT', NULL, true);