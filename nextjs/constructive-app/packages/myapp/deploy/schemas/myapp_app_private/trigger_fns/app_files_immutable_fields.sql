-- Deploy: schemas/myapp_app_private/trigger_fns/app_files_immutable_fields
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema


CREATE FUNCTION myapp_app_private.app_files_immutable_fields() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF (((NEW.actor_id IS DISTINCT FROM OLD.actor_id OR NEW.is_public IS DISTINCT FROM OLD.is_public) OR NEW.mime_type IS DISTINCT FROM OLD.mime_type) OR NEW.size IS DISTINCT FROM OLD.size) OR NEW.content_hash IS DISTINCT FROM OLD.content_hash THEN
    RAISE EXCEPTION 'Cannot modify immutable fields on app_files';
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

