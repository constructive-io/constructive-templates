-- Verify: schemas/routing_public/tables/apis/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.apis' AS regclass), 'authenticated', 'UPDATE', NULL, true);