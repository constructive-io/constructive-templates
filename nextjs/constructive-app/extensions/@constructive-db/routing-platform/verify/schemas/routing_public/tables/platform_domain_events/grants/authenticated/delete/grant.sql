-- Verify: schemas/routing_public/tables/platform_domain_events/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.platform_domain_events' AS regclass), 'authenticated', 'DELETE', NULL, true);