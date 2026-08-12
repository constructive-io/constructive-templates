-- Verify: schemas/routing_public/tables/sites/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.sites' AS regclass), 'authenticated', 'DELETE', NULL, true);