-- Deploy: schemas/routing_public/tables/site_web_configs/triggers/catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/site_web_configs/table
-- requires: schemas/catalog_private/trigger_fns/tg_site_web_configs_catalog_sync


CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.site_web_configs
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_web_configs_catalog_sync();