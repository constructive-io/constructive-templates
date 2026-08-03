-- Revert: schemas/myapp_storage_public/tables/app_buckets/grants/authenticated/insert/grant


REVOKE INSERT ON myapp_storage_public.app_buckets FROM authenticated;


