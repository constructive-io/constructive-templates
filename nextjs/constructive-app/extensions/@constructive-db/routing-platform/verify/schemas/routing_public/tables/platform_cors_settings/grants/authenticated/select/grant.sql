-- Verify: schemas/routing_public/tables/platform_cors_settings/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.platform_cors_settings', 'SELECT', 'authenticated');