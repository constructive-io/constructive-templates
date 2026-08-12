-- Deploy: schemas/routing_public/tables/site_error_pages/triggers/catalog_del
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/site_error_pages/table
-- requires: schemas/catalog_private/trigger_fns/tg_site_error_pages_catalog_del


CREATE TRIGGER catalog_del
  AFTER DELETE
  ON routing_public.site_error_pages
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_site_error_pages_catalog_del();