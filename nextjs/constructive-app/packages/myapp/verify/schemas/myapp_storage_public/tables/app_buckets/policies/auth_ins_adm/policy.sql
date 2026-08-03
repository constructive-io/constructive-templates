-- Verify: schemas/myapp_storage_public/tables/app_buckets/policies/auth_ins_adm/policy


SELECT verify_policy('auth_ins_adm', 'myapp_storage_public.app_buckets');


