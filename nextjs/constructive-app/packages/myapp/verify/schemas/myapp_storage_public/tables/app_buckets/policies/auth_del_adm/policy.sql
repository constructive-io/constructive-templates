-- Verify: schemas/myapp_storage_public/tables/app_buckets/policies/auth_del_adm/policy


SELECT assert_policy('myapp_storage_public.app_buckets'::regclass, 'auth_del_adm', 'DELETE', true, true, false);


