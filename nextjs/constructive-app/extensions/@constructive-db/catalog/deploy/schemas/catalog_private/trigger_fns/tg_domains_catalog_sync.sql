-- Deploy: schemas/catalog_private/trigger_fns/tg_domains_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_domains_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.domains (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    hostname,
    is_wildcard,
    parent_hostname,
    managed,
    verification_status,
    tls_status,
    tls_secret_name
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.hostname, new.is_wildcard, new.parent_hostname, new.managed, new.verification_status, new.tls_status, new.tls_secret_name) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    hostname = excluded.hostname,
    is_wildcard = excluded.is_wildcard,
    parent_hostname = excluded.parent_hostname,
    managed = excluded.managed,
    verification_status = excluded.verification_status,
    tls_status = excluded.tls_status,
    tls_secret_name = excluded.tls_secret_name;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;