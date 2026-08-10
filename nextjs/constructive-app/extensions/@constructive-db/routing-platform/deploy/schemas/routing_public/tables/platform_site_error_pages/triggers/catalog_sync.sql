-- Deploy: schemas/routing_public/tables/platform_site_error_pages/triggers/catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/platform_site_error_pages/table
-- requires: schemas/catalog_private/trigger_fns/tg_platform_site_error_pages_catalog_sync


CREATE TRIGGER catalog_sync
  AFTER INSERT OR UPDATE
  ON routing_public.platform_site_error_pages
  FOR EACH ROW
  EXECUTE PROCEDURE catalog_private.tg_platform_site_error_pages_catalog_sync();