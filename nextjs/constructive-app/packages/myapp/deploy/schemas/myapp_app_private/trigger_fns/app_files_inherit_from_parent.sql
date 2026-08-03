-- Deploy: schemas/myapp_app_private/trigger_fns/app_files_inherit_from_parent
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema


CREATE FUNCTION myapp_app_private.app_files_inherit_from_parent() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  SELECT p.is_public
  FROM ONLY myapp_storage_public.app_buckets AS p
  WHERE
    p.id = NEW.bucket_id INTO NEW.is_public;
  IF NOT (FOUND) THEN
    RAISE EXCEPTION 'Parent not found: %', NEW.bucket_id;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

