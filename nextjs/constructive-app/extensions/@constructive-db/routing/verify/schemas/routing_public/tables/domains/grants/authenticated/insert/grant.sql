-- Verify: schemas/routing_public/tables/domains/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.domains', 'INSERT', 'authenticated');