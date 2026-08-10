-- Deploy: schemas/myapp_storage_private/trigger_fns/app_files_promotion_guard
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_private/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_files/columns/promoted_at/column
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/destination_bucket_id/column


CREATE FUNCTION myapp_storage_private.app_files_promotion_guard() RETURNS TRIGGER AS $_PGFN_$
DECLARE
  v_destination_bucket_id uuid;
  v_destination_is_public boolean;
BEGIN
  IF NEW.bucket_id IS DISTINCT FROM OLD.bucket_id THEN
    SELECT
      src.destination_bucket_id,
    (SELECT dest.is_public
    FROM myapp_storage_public.app_buckets AS dest
    WHERE
        dest.id = src.destination_bucket_id)
    FROM myapp_storage_public.app_buckets AS src
    WHERE
      src.id = OLD.bucket_id AND src.type = 'temp' INTO v_destination_bucket_id, v_destination_is_public;
    IF v_destination_bucket_id IS NULL THEN
      PERFORM errors.raise_error('STORAGE_FILE_BUCKET_IMMUTABLE', jsonb_build_object('file_id', OLD.id, 'from_bucket_id', OLD.bucket_id, 'to_bucket_id', NEW.bucket_id), 'internal');
    END IF;
    IF NEW.bucket_id <> v_destination_bucket_id THEN
      PERFORM errors.raise_error('STORAGE_PROMOTION_DESTINATION_MISMATCH', jsonb_build_object('file_id', OLD.id, 'from_bucket_id', OLD.bucket_id, 'to_bucket_id', NEW.bucket_id, 'expected_bucket_id', v_destination_bucket_id), 'internal');
    END IF;
    IF v_destination_is_public IS DISTINCT FROM NEW.is_public THEN
      PERFORM errors.raise_error('STORAGE_PROMOTION_VISIBILITY_MISMATCH', jsonb_build_object('file_id', OLD.id, 'to_bucket_id', NEW.bucket_id, 'file_is_public', NEW.is_public, 'bucket_is_public', v_destination_is_public), 'internal');
    END IF;
    SELECT now() INTO NEW.promoted_at;
  ELSE
    IF NEW.key IS DISTINCT FROM OLD.key THEN
      PERFORM errors.raise_error('STORAGE_FILE_KEY_IMMUTABLE', jsonb_build_object('file_id', OLD.id, 'key', OLD.key, 'attempted_key', NEW.key), 'internal');
    END IF;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

