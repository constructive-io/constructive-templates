-- Deploy: schemas/routing_public/tables/apis/triggers/catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table
-- requires: schemas/catalog_public/trigger_fns/tg_apis_catalog_sync


CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.apis
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_public.tg_apis_catalog_sync();