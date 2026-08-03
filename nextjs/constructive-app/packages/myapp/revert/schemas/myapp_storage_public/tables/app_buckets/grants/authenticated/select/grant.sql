-- Revert: schemas/myapp_storage_public/tables/app_buckets/grants/authenticated/select/grant


REVOKE SELECT ON myapp_storage_public.app_buckets FROM authenticated;


