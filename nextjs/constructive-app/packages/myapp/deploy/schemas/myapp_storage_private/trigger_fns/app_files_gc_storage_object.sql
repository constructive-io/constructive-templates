-- Deploy: schemas/myapp_storage_private/trigger_fns/app_files_gc_storage_object
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_private/schema


CREATE FUNCTION myapp_storage_private.app_files_gc_storage_object() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  PERFORM app_jobs.add_job(identifier:='delete_s3_object', payload:=json_build_object('table', 'app_files', 'schema', 'myapp_storage_public', 'bucket_id', OLD.bucket_id, 'file_id', OLD.id, 'key', OLD.key, 'database_id', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'), queue_name:='storage_gc', run_at:=now() + '5 seconds'::interval, max_attempts:=5, priority:=100);
  RETURN OLD;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

