-- Verify: schemas/routing_public/tables/rls_settings/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.rls_settings', 'SELECT', 'authenticated');