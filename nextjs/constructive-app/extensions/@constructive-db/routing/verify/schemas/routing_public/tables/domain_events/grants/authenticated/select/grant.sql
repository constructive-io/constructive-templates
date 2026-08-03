-- Verify: schemas/routing_public/tables/domain_events/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.domain_events', 'SELECT', 'authenticated');