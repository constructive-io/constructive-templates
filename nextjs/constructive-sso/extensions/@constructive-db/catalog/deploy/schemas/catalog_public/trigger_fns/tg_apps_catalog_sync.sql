-- Deploy: schemas/catalog_public/trigger_fns/tg_apps_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema


CREATE FUNCTION catalog_public.tg_apps_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_public.apps (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    config
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.name, new.config) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    config = excluded.config;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;