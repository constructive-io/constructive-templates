-- Verify: schemas/routing_public/procedures/api_schema_names/procedure


SELECT assert_function(CAST('routing_public.api_schema_names(uuid)' AS regprocedure), CAST('jsonb' AS regtype), false, true, 'STABLE');