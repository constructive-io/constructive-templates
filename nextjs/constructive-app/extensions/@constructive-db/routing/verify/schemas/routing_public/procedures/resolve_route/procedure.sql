-- Verify: schemas/routing_public/procedures/resolve_route/procedure


SELECT assert_function(CAST('routing_public.resolve_route(text, text, text)' AS regprocedure), CAST('record' AS regtype), false, true, 'STABLE');