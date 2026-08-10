-- Verify: schemas/myapp_storage_public/tables/app_files/policies/auth_sel_mem/policy


SELECT assert_policy('myapp_storage_public.app_files'::regclass, 'auth_sel_mem', 'SELECT', true, true, false);


