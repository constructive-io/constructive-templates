-- Verify: schemas/myapp_storage_public/tables/app_files/policies/auth_del_own/policy


SELECT assert_policy('myapp_storage_public.app_files'::regclass, 'auth_del_own', 'DELETE', true, true, false);


