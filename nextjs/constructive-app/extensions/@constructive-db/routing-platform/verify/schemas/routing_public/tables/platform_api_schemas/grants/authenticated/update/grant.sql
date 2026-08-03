-- Verify: schemas/routing_public/tables/platform_api_schemas/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.platform_api_schemas', 'UPDATE', 'authenticated');