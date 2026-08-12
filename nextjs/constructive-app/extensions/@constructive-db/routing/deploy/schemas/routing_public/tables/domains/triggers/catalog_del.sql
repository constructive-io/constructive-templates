-- Deploy: schemas/routing_public/tables/domains/triggers/catalog_del
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/catalog_private/trigger_fns/tg_domains_catalog_del


CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.domains
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_domains_catalog_del();