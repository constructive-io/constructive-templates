-- Verify: schemas/routing_public/tables/domains/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.domains' AS regclass), 'authenticated', 'DELETE', NULL, true);