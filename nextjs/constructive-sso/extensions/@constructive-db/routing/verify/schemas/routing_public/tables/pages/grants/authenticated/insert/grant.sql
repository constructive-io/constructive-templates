-- Verify: schemas/routing_public/tables/pages/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.pages' AS regclass), 'authenticated', 'INSERT', NULL, true);