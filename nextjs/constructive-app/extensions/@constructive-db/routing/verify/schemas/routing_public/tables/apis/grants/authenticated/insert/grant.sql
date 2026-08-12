-- Verify: schemas/routing_public/tables/apis/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.apis' AS regclass), 'authenticated', 'INSERT', NULL, true);