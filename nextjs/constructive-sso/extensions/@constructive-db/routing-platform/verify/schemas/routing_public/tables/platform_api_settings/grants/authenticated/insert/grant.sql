-- Verify: schemas/routing_public/tables/platform_api_settings/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.platform_api_settings', 'INSERT', 'authenticated');