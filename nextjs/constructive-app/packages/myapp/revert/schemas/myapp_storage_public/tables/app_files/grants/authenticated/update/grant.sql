-- Revert: schemas/myapp_storage_public/tables/app_files/grants/authenticated/update/grant


REVOKE UPDATE (filename, description, tags) ON myapp_storage_public.app_files FROM authenticated;


