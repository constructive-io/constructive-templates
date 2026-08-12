-- Verify: schemas/catalog_private/trigger_fns/tg_function_capability_bindings_catalog_sync


SELECT assert_function(CAST('catalog_private.tg_function_capability_bindings_catalog_sync()' AS regprocedure), CAST('TRIGGER' AS regtype), false, true, 'VOLATILE');