-- Verify: schemas/routing_public/tables/platform_domain_events/indexes/platform_domain_events_domain_id_idx


SELECT verify_index('routing_public.platform_domain_events', 'platform_domain_events_domain_id_idx');