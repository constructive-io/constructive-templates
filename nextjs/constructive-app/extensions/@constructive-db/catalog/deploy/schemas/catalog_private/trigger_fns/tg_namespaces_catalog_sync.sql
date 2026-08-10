-- Deploy: schemas/catalog_private/trigger_fns/tg_namespaces_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_namespaces_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.namespaces (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_name
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.namespace_name) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_name = excluded.namespace_name;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;