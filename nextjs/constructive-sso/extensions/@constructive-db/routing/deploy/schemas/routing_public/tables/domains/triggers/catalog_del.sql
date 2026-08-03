-- Deploy: schemas/routing_public/tables/domains/triggers/catalog_del
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/catalog_public/trigger_fns/tg_domains_catalog_del


CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.domains
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_public.tg_domains_catalog_del();