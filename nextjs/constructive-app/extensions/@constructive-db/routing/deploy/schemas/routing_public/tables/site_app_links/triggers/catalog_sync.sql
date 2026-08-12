-- Deploy: schemas/routing_public/tables/site_app_links/triggers/catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/site_app_links/table
-- requires: schemas/catalog_private/trigger_fns/tg_site_app_links_catalog_sync


CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.site_app_links
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_app_links_catalog_sync();