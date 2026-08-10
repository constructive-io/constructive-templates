-- Deploy: schemas/myapp_storage_private/procedures/expire_staged_app_files/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_private/schema
-- requires: schemas/myapp_storage_private/procedures/app_files_staged_expiry_candidates/procedure


CREATE FUNCTION myapp_storage_private.expire_staged_app_files() RETURNS void AS $_PGFN_$
DECLARE
  v_candidate RECORD;
BEGIN
  FOR v_candidate IN SELECT
    c.file_id,
    c.file_key,
    c.bucket_id
  FROM myapp_storage_private.app_files_staged_expiry_candidates() AS c LOOP
    PERFORM app_jobs.add_job(identifier:='delete_s3_object', payload:=json_build_object('table', 'app_files', 'schema', 'myapp_storage_public', 'file_id', v_candidate.file_id, 'key', v_candidate.file_key, 'bucket_id', v_candidate.bucket_id), queue_name:='storage_gc', max_attempts:=5, priority:=100, db_id:='019feb75-7843-7bd5-a19f-88c4cbec0ee6'::uuid);
    UPDATE myapp_storage_public.app_files AS f SET
    expiry_enqueued_at = now()
    WHERE
      f.id = v_candidate.file_id;
  END LOOP;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

