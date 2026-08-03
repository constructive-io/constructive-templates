-- Verify: schemas/routing_public/tables/platform_api_schemas/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.platform_api_schemas', 'DELETE', 'authenticated');