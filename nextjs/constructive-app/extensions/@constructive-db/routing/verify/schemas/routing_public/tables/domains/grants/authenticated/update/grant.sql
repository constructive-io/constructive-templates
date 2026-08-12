-- Verify: schemas/routing_public/tables/domains/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.domains' AS regclass), 'authenticated', 'UPDATE', NULL, true);