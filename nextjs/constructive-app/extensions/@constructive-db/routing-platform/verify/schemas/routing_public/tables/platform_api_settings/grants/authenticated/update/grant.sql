-- Verify: schemas/routing_public/tables/platform_api_settings/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.platform_api_settings', 'UPDATE', 'authenticated');