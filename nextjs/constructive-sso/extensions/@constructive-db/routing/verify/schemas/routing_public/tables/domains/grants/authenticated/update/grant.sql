-- Verify: schemas/routing_public/tables/domains/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.domains', 'UPDATE', 'authenticated');