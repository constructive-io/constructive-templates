-- Verify: schemas/routing_public/tables/api_settings/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.api_settings', 'INSERT', 'authenticated');