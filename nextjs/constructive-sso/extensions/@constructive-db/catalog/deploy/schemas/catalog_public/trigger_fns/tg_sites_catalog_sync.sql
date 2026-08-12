-- Deploy: schemas/catalog_public/trigger_fns/tg_sites_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema


CREATE FUNCTION catalog_public.tg_sites_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_public.sites (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    title,
    description,
    config
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.name, new.title, new.description, new.config) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    title = excluded.title,
    description = excluded.description,
    config = excluded.config;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;