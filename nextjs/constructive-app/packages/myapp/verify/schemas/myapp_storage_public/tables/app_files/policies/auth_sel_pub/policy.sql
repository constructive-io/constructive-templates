-- Verify: schemas/myapp_storage_public/tables/app_files/policies/auth_sel_pub/policy


SELECT assert_policy('myapp_storage_public.app_files'::regclass, 'auth_sel_pub', 'SELECT', true, true, false);


