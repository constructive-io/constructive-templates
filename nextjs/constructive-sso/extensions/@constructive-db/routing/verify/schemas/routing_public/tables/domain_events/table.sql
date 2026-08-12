-- Verify: schemas/routing_public/tables/domain_events/table


SELECT assert_table(CAST('routing_public.domain_events' AS regclass), false, NULL);