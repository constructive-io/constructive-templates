-- Deploy: schemas/catalog_public/trigger_fns/tg_platform_buckets_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema


CREATE FUNCTION catalog_public.tg_platform_buckets_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_public.buckets (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    key,
    type,
    physical_name
  ) VALUES
    (new.id, 'platform', NULL, COALESCE(new.is_public, false), jwt_private.current_database_id(), new.key, new.type, new.physical_name) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    key = excluded.key,
    type = excluded.type,
    physical_name = excluded.physical_name;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;