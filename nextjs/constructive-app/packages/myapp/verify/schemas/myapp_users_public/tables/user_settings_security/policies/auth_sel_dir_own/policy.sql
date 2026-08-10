-- Verify: schemas/myapp_users_public/tables/user_settings_security/policies/auth_sel_dir_own/policy


SELECT assert_policy('myapp_users_public.user_settings_security'::regclass, 'auth_sel_dir_own', 'SELECT', true, true, false);


