-- Revert: schemas/myapp_storage_public/tables/app_files/grants/authenticated/select/grant


REVOKE SELECT ON myapp_storage_public.app_files FROM authenticated;


