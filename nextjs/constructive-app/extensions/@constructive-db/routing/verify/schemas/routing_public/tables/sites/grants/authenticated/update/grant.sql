-- Verify: schemas/routing_public/tables/sites/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.sites' AS regclass), 'authenticated', 'UPDATE', NULL, true);