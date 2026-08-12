-- Deploy: schemas/catalog_public/trigger_fns/tg_platform_function_definitions_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema


CREATE FUNCTION catalog_public.tg_platform_function_definitions_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_public.functions (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    task_identifier
  ) VALUES
    (new.id, 'platform', NULL, COALESCE(new.is_published, false), jwt_private.current_database_id(), new.task_identifier) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    task_identifier = excluded.task_identifier;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;