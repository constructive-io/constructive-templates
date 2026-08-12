-- Deploy: schemas/catalog_private/trigger_fns/tg_function_capability_bindings_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_function_capability_bindings_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.bindings (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    function_id,
    graph_id,
    bucket_id,
    lifecycle,
    key
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.function_id, new.graph_id, new.bucket_id, new.lifecycle, new.key) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    function_id = excluded.function_id,
    graph_id = excluded.graph_id,
    bucket_id = excluded.bucket_id,
    lifecycle = excluded.lifecycle,
    key = excluded.key;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;