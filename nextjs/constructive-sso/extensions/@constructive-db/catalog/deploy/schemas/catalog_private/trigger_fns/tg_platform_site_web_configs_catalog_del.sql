-- Deploy: schemas/catalog_private/trigger_fns/tg_platform_site_web_configs_catalog_del
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_platform_site_web_configs_catalog_del() RETURNS trigger AS $$BEGIN
  DELETE FROM catalog_private.sites_web_config WHERE id = old.id;
  RETURN OLD;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;