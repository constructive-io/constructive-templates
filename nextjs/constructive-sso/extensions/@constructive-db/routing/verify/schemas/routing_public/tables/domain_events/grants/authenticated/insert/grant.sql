-- Verify: schemas/routing_public/tables/domain_events/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.domain_events', 'INSERT', 'authenticated');