-- Deploy: schemas/routing_public/tables/platform_site_web_configs/triggers/catalog_del
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/platform_site_web_configs/table
-- requires: schemas/catalog_private/trigger_fns/tg_platform_site_web_configs_catalog_del


CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.platform_site_web_configs
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_platform_site_web_configs_catalog_del();