-- Deploy: schemas/catalog_private/trigger_fns/tg_sites_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_sites_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.sites (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    name,
    title,
    description,
    bucket_id,
    resource_id,
    installation_id,
    installation_member_slug
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.name, new.title, new.description, new.bucket_id, new.resource_id, new.installation_id, new.installation_member_slug) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    name = excluded.name,
    title = excluded.title,
    description = excluded.description,
    bucket_id = excluded.bucket_id,
    resource_id = excluded.resource_id,
    installation_id = excluded.installation_id,
    installation_member_slug = excluded.installation_member_slug;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;