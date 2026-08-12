-- Verify: schemas/routing_public/tables/managed_domains/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.managed_domains', 'SELECT', 'authenticated');