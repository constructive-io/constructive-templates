-- Verify: schemas/routing_public/tables/platform_domain_events/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.platform_domain_events', 'UPDATE', 'authenticated');