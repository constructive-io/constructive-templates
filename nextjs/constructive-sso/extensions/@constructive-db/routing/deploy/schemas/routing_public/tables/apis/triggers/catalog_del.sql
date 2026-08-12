-- Deploy: schemas/routing_public/tables/apis/triggers/catalog_del
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table
-- requires: schemas/catalog_public/trigger_fns/tg_apis_catalog_del


CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.apis
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_public.tg_apis_catalog_del();