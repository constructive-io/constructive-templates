-- Deploy: schemas/catalog_public/trigger_fns/tg_apps_catalog_del
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema


CREATE FUNCTION catalog_public.tg_apps_catalog_del() RETURNS trigger AS $$BEGIN
  DELETE FROM catalog_public.apps WHERE id = old.id;
  RETURN OLD;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;