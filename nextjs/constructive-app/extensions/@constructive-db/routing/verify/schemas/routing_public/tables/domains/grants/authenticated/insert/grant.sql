-- Verify: schemas/routing_public/tables/domains/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.domains' AS regclass), 'authenticated', 'INSERT', NULL, true);