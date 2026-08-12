-- Verify: schemas/routing_public/tables/domain_events/indexes/domain_events_domain_id_idx


SELECT assert_index(CAST('routing_public.domain_events_domain_id_idx' AS regclass), CAST('routing_public.domain_events' AS regclass), false);