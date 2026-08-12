-- Deploy: schemas/catalog_private/trigger_fns/tg_buckets_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_buckets_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.buckets (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    key,
    type,
    physical_name,
    tags
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_public, false), new.database_id, new.key, new.type, new.physical_name, new.tags) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    key = excluded.key,
    type = excluded.type,
    physical_name = excluded.physical_name,
    tags = excluded.tags;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;