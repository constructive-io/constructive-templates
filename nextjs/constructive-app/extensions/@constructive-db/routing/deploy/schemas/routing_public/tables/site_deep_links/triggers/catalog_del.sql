-- Deploy: schemas/routing_public/tables/site_deep_links/triggers/catalog_del
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/site_deep_links/table
-- requires: schemas/catalog_private/trigger_fns/tg_site_deep_links_catalog_del


CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.site_deep_links
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_deep_links_catalog_del();