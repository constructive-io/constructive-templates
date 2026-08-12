-- Verify: schemas/catalog_private/trigger_fns/tg_site_web_configs_catalog_del


SELECT assert_function(CAST('catalog_private.tg_site_web_configs_catalog_del()' AS regprocedure), CAST('TRIGGER' AS regtype), false, true, 'VOLATILE');