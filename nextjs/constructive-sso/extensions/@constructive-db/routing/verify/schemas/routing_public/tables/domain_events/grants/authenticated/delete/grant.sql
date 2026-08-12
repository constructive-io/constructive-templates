-- Verify: schemas/routing_public/tables/domain_events/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.domain_events', 'DELETE', 'authenticated');