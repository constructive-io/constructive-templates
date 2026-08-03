-- Verify: schemas/routing_public/tables/cors_settings/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.cors_settings', 'INSERT', 'authenticated');