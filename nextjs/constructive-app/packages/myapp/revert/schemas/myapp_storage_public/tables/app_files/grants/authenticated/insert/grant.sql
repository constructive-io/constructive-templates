-- Revert: schemas/myapp_storage_public/tables/app_files/grants/authenticated/insert/grant


REVOKE INSERT ON myapp_storage_public.app_files FROM authenticated;


