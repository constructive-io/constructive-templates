-- Verify: schemas/routing_public/tables/platform_domain_events/indexes/platform_domain_events_managed_domain_id_idx


SELECT assert_index(CAST('routing_public.platform_domain_events_managed_domain_id_idx' AS regclass), CAST('routing_public.platform_domain_events' AS regclass), false);