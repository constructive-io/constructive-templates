-- Verify: schemas/myapp_storage_public/tables/app_buckets/policies/auth_del_adm/policy


SELECT verify_policy('auth_del_adm', 'myapp_storage_public.app_buckets');


