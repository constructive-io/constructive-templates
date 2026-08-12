-- Deploy: schemas/catalog_private/trigger_fns/tg_site_web_configs_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_site_web_configs_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.sites_web_config (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    index_document,
    clean_urls,
    spa_fallback,
    metadata
  ) VALUES
    (new.id, 'database', new.database_id, false, new.database_id, new.site_id, new.index_document, new.clean_urls, new.spa_fallback, new.metadata) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    index_document = excluded.index_document,
    clean_urls = excluded.clean_urls,
    spa_fallback = excluded.spa_fallback,
    metadata = excluded.metadata;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;