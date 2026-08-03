-- Verify: schemas/routing_public/tables/cors_settings/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.cors_settings', 'SELECT', 'authenticated');