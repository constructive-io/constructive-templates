-- Deploy: schemas/myapp_storage_public/procedures/app_files_rename/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table


CREATE FUNCTION myapp_storage_public.app_files_rename(
  IN file_id pg_catalog.uuid,
  IN new_filename pg_catalog.text
) RETURNS myapp_storage_public.app_files AS $_PGFN_$
UPDATE myapp_storage_public.app_files SET
filename = new_filename
WHERE
  id = file_id
RETURNING *
$_PGFN_$ LANGUAGE sql VOLATILE;

