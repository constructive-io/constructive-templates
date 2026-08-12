-- Verify: schemas/routing_public/tables/sites/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.sites', 'SELECT', 'authenticated');