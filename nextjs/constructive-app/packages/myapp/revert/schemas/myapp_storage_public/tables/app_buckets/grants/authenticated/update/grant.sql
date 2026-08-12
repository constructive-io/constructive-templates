-- Revert: schemas/myapp_storage_public/tables/app_buckets/grants/authenticated/update/grant


REVOKE UPDATE ON myapp_storage_public.app_buckets FROM authenticated;


