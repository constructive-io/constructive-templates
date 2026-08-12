-- Verify: schemas/routing_public/tables/database_settings/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.database_settings', 'DELETE', 'authenticated');