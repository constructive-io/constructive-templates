-- Deploy: schemas/myapp_storage_private/procedures/app_files_staged_expiry_candidates/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_private/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_storage_public/tables/app_files/columns/promoted_at/column
-- requires: schemas/myapp_storage_public/tables/app_buckets/columns/staging_ttl/column
-- requires: schemas/myapp_storage_public/tables/app_files/columns/expiry_enqueued_at/column


CREATE FUNCTION myapp_storage_private.app_files_staged_expiry_candidates() RETURNS TABLE (
  file_id uuid,
  file_key text,
  bucket_id uuid,
  expires_at timestamptz
) AS $_PGFN_$
BEGIN
  RETURN QUERY SELECT
    f.id,
    f.key,
    f.bucket_id,
    f.created_at + b.staging_ttl
  FROM myapp_storage_public.app_files AS f, myapp_storage_public.app_buckets AS b
  WHERE
    ((b.id = f.bucket_id AND b.type = 'temp') AND (b.staging_ttl IS NOT NULL AND f.promoted_at IS NULL)) AND (f.expiry_enqueued_at IS NULL AND (f.created_at + b.staging_ttl) <= now());
END;
$_PGFN_$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

