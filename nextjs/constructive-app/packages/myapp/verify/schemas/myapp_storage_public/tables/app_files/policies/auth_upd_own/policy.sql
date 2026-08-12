-- Verify: schemas/myapp_storage_public/tables/app_files/policies/auth_upd_own/policy


SELECT assert_policy('myapp_storage_public.app_files'::regclass, 'auth_upd_own', 'UPDATE', true, true, false);


