-- Verify: schemas/myapp_storage_public/tables/app_buckets/policies/auth_upd_adm/policy


SELECT assert_policy('myapp_storage_public.app_buckets'::regclass, 'auth_upd_adm', 'UPDATE', true, true, false);


