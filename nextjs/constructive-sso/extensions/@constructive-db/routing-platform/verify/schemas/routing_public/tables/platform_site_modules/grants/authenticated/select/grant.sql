-- Verify: schemas/routing_public/tables/platform_site_modules/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.platform_site_modules', 'SELECT', 'authenticated');