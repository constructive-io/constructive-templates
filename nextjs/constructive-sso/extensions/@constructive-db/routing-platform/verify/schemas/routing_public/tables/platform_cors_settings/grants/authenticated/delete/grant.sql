-- Verify: schemas/routing_public/tables/platform_cors_settings/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.platform_cors_settings', 'DELETE', 'authenticated');