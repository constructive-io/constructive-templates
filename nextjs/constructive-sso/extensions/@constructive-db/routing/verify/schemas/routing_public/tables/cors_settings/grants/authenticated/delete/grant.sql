-- Verify: schemas/routing_public/tables/cors_settings/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.cors_settings', 'DELETE', 'authenticated');