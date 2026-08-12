-- Deploy: schemas/catalog_private/trigger_fns/tg_site_deep_links_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_site_deep_links_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.sites_deep_links (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    slug,
    app_path,
    web_path,
    fallback_url
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.site_id, new.slug, new.app_path, new.web_path, new.fallback_url) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    slug = excluded.slug,
    app_path = excluded.app_path,
    web_path = excluded.web_path,
    fallback_url = excluded.fallback_url;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;