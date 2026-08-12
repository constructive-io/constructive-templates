-- Verify: schemas/routing_public/tables/domain_events/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.domain_events', 'UPDATE', 'authenticated');