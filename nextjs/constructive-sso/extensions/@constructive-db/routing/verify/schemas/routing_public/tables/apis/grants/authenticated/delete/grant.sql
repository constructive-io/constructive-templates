-- Verify: schemas/routing_public/tables/apis/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.apis' AS regclass), 'authenticated', 'DELETE', NULL, true);