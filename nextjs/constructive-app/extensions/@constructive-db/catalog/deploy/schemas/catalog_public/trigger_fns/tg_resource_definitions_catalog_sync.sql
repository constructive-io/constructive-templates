-- Deploy: schemas/catalog_public/trigger_fns/tg_resource_definitions_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema


CREATE FUNCTION catalog_public.tg_resource_definitions_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_public.resource_definitions (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_id,
    kind,
    slug
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.namespace_id, new.kind, new.slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_id = excluded.namespace_id,
    kind = excluded.kind,
    slug = excluded.slug;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;