-- Deploy: schemas/catalog_private/trigger_fns/tg_platform_site_app_links_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_platform_site_app_links_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.sites_app_links (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    site_id,
    platform,
    app_identifier,
    team_id,
    sha256_cert_fingerprints,
    path_components,
    webcredentials,
    store_url
  ) VALUES
    (new.id, 'platform', NULL, false, jwt_private.current_database_id(), new.site_id, new.platform, new.app_identifier, new.team_id, new.sha256_cert_fingerprints, new.path_components, new.webcredentials, new.store_url) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    site_id = excluded.site_id,
    platform = excluded.platform,
    app_identifier = excluded.app_identifier,
    team_id = excluded.team_id,
    sha256_cert_fingerprints = excluded.sha256_cert_fingerprints,
    path_components = excluded.path_components,
    webcredentials = excluded.webcredentials,
    store_url = excluded.store_url;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;