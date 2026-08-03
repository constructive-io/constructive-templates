-- Verify: schemas/routing_public/tables/api_settings/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.api_settings', 'DELETE', 'authenticated');