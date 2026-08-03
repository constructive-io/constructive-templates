-- Verify: schemas/routing_public/tables/api_settings/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.api_settings', 'SELECT', 'authenticated');