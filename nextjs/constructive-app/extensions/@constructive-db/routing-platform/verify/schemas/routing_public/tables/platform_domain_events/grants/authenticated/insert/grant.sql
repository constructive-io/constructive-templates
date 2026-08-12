-- Verify: schemas/routing_public/tables/platform_domain_events/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.platform_domain_events' AS regclass), 'authenticated', 'INSERT', NULL, true);