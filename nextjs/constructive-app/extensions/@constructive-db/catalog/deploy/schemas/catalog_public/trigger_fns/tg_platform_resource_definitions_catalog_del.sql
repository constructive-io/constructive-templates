-- Deploy: schemas/catalog_public/trigger_fns/tg_platform_resource_definitions_catalog_del
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema


CREATE FUNCTION catalog_public.tg_platform_resource_definitions_catalog_del() RETURNS trigger AS $$BEGIN
  DELETE FROM catalog_public.resource_definitions WHERE id = old.id;
  RETURN OLD;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;