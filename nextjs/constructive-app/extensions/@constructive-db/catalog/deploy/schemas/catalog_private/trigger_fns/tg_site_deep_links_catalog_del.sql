-- Deploy: schemas/catalog_private/trigger_fns/tg_site_deep_links_catalog_del
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_site_deep_links_catalog_del() RETURNS trigger AS $$BEGIN
  DELETE FROM catalog_private.sites_deep_links WHERE id = old.id;
  RETURN OLD;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;