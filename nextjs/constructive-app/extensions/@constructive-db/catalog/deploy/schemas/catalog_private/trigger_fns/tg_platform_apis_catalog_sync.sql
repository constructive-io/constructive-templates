-- Deploy: schemas/catalog_private/trigger_fns/tg_platform_apis_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_platform_apis_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.apis (
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
    (new.id, 'platform', NULL, COALESCE(new.is_published, false), jwt_private.current_database_id(), new.name, new.dbname, new.role_name, new.anon_role, new.config) ON CONFLICT (id) DO UPDATE SET 
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