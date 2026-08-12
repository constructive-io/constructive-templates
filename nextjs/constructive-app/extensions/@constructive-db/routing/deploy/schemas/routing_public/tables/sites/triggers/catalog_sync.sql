-- Deploy: schemas/routing_public/tables/sites/triggers/catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/catalog_private/trigger_fns/tg_sites_catalog_sync


CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.sites
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_sites_catalog_sync();