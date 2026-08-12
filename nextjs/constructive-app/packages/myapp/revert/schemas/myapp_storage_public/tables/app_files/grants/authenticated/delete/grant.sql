-- Revert: schemas/myapp_storage_public/tables/app_files/grants/authenticated/delete/grant


REVOKE DELETE ON myapp_storage_public.app_files FROM authenticated;


