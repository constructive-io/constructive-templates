-- Verify: schemas/routing_public/tables/database_settings/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.database_settings', 'INSERT', 'authenticated');