-- Deploy: schemas/catalog_private/trigger_fns/tg_platform_site_error_pages_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_platform_site_error_pages_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.sites_error_pages (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    status_code,
    object_path
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.site_id, new.status_code, new.object_path) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    status_code = excluded.status_code,
    object_path = excluded.object_path;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;