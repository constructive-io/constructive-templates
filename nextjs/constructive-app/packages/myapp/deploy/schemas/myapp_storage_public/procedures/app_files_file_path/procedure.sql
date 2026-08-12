-- Deploy: schemas/myapp_storage_public/procedures/app_files_file_path/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table


CREATE FUNCTION myapp_storage_public.app_files_file_path(
  IN f myapp_storage_public.app_files
) RETURNS text AS $_PGFN_$
SELECT f.filename
$_PGFN_$ LANGUAGE sql STABLE;

