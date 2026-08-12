-- Verify: schemas/routing_public/tables/sites/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.sites' AS regclass), 'authenticated', 'INSERT', NULL, true);