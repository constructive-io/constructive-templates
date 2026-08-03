-- Deploy: schemas/routing_public/tables/domains/triggers/catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/catalog_public/trigger_fns/tg_domains_catalog_sync


CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.domains
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_public.tg_domains_catalog_sync();