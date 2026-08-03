-- Verify: schemas/routing_public/tables/domain_events/indexes/domain_events_domain_id_idx


SELECT verify_index('routing_public.domain_events', 'domain_events_domain_id_idx');