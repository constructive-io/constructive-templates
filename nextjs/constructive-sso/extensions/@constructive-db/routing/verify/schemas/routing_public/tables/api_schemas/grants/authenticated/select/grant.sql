-- Verify: schemas/routing_public/tables/api_schemas/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.api_schemas', 'SELECT', 'authenticated');