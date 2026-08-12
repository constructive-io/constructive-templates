-- Verify: schemas/myapp_storage_public/tables/app_buckets/policies/auth_ins_adm/policy


SELECT assert_policy('myapp_storage_public.app_buckets'::regclass, 'auth_ins_adm', 'INSERT', true, false, true);


