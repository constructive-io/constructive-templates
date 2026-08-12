-- Verify: schemas/routing_public/tables/pages/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.pages' AS regclass), 'authenticated', 'UPDATE', NULL, true);