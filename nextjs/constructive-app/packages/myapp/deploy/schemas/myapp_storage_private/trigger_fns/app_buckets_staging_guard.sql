-- Deploy: schemas/myapp_storage_private/trigger_fns/app_buckets_staging_guard
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_private/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/staging_ttl/column
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/destination_bucket_id/column


CREATE FUNCTION myapp_storage_private.app_buckets_staging_guard() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF NEW.type = 'temp' THEN
    IF NEW.destination_bucket_id IS NULL THEN
      PERFORM errors.raise_error('STORAGE_STAGING_BUCKET_NO_DESTINATION', jsonb_build_object('bucket_key', NEW.key), 'internal');
    END IF;
    IF NEW.staging_ttl IS NULL THEN
      PERFORM errors.raise_error('STORAGE_STAGING_BUCKET_NO_TTL', jsonb_build_object('bucket_key', NEW.key), 'internal');
    END IF;
    IF NEW.staging_ttl <= '0'::interval THEN
      PERFORM errors.raise_error('STORAGE_STAGING_TTL_INVALID', jsonb_build_object('bucket_key', NEW.key, 'staging_ttl', NEW.staging_ttl), 'internal');
    END IF;
    IF NOT (EXISTS (SELECT 1
    FROM myapp_storage_public.app_buckets AS dest
    WHERE
      dest.id = NEW.destination_bucket_id AND dest.type <> 'temp')) THEN
      PERFORM errors.raise_error('STORAGE_STAGING_DESTINATION_INVALID', jsonb_build_object('bucket_key', NEW.key, 'destination_bucket_id', NEW.destination_bucket_id), 'internal');
    END IF;
  ELSE
    IF NEW.destination_bucket_id IS NOT NULL THEN
      PERFORM errors.raise_error('STORAGE_DESTINATION_REQUIRES_TEMP', jsonb_build_object('bucket_key', NEW.key, 'bucket_type', NEW.type), 'internal');
    END IF;
    IF NEW.staging_ttl IS NOT NULL THEN
      PERFORM errors.raise_error('STORAGE_STAGING_TTL_REQUIRES_TEMP', jsonb_build_object('bucket_key', NEW.key, 'bucket_type', NEW.type), 'internal');
    END IF;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

