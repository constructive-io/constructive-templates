-- Verify: schemas/routing_public/tables/domains/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.domains', 'DELETE', 'authenticated');