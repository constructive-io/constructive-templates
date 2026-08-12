-- Verify: schemas/routing_public/tables/platform_domain_events/table


SELECT assert_table(CAST('routing_public.platform_domain_events' AS regclass), false, NULL);