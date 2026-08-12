-- Verify: schemas/routing_public/tables/domain_events/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.domain_events' AS regclass), 'authenticated', 'INSERT', NULL, true);