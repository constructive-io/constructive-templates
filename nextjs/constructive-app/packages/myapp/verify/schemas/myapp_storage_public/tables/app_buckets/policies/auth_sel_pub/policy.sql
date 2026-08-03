-- Verify: schemas/myapp_storage_public/tables/app_buckets/policies/auth_sel_pub/policy


SELECT verify_policy('auth_sel_pub', 'myapp_storage_public.app_buckets');


