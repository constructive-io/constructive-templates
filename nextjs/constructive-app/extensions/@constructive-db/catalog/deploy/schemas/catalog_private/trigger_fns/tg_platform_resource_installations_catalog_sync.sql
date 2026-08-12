-- Deploy: schemas/catalog_private/trigger_fns/tg_platform_resource_installations_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_platform_resource_installations_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.resource_installations (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    namespace_id,
    slug
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.namespace_id, new.slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    namespace_id = excluded.namespace_id,
    slug = excluded.slug;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;