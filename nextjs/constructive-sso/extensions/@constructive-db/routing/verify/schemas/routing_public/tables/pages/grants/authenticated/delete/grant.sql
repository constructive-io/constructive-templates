-- Verify: schemas/routing_public/tables/pages/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.pages' AS regclass), 'authenticated', 'DELETE', NULL, true);