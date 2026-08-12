-- Deploy: schemas/catalog_private/trigger_fns/tg_function_definitions_catalog_sync
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


CREATE FUNCTION catalog_private.tg_function_definitions_catalog_sync() RETURNS trigger AS $$BEGIN
  INSERT INTO catalog_private.functions (
    id,
    owner_scope,
    owner_key,
    is_visible,
    database_id,
    task_identifier,
    queue_name,
    priority,
    max_attempts
  ) VALUES
    (new.id, 'database', new.database_id, COALESCE(new.is_published, false), new.database_id, new.task_identifier, new.queue_name, new.priority, new.max_attempts) ON CONFLICT (id) DO UPDATE SET 
    owner_key = excluded.owner_key,
    is_visible = excluded.is_visible,
    database_id = excluded.database_id,
    task_identifier = excluded.task_identifier,
    queue_name = excluded.queue_name,
    priority = excluded.priority,
    max_attempts = excluded.max_attempts;
  RETURN NEW;
END$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;