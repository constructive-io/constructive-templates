-- Verify: schemas/routing_public/tables/api_schemas/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.api_schemas', 'UPDATE', 'authenticated');