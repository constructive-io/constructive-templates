-- Deploy: schemas/catalog_public/trigger_fns/tg_apis_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema


CREATE FUNCTION catalog_public.tg_apis_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_public.apis (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    dbname,
    role_name,
    anon_role,
    config
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.name, new.dbname, new.role_name, new.anon_role, new.config) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    dbname = excluded.dbname,
    role_name = excluded.role_name,
    anon_role = excluded.anon_role,
    config = excluded.config;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;