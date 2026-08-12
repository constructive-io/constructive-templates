-- Verify: schemas/catalog_private/trigger_fns/tg_resource_definitions_catalog_sync


SELECT assert_function(CAST('catalog_private.tg_resource_definitions_catalog_sync()' AS regprocedure), CAST('TRIGGER' AS regtype), false, true, 'VOLATILE');