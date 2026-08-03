-- Verify: schemas/routing_public/tables/domains/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.domains', 'SELECT', 'authenticated');