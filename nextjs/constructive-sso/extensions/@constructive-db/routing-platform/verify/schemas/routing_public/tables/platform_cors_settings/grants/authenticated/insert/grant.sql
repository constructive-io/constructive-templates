-- Verify: schemas/routing_public/tables/platform_cors_settings/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.platform_cors_settings', 'INSERT', 'authenticated');