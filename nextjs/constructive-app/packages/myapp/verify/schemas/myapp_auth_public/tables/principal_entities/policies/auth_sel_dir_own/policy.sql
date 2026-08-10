-- Verify: schemas/myapp_auth_public/tables/principal_entities/policies/auth_sel_dir_own/policy


SELECT assert_policy('myapp_auth_public.principal_entities'::regclass, 'auth_sel_dir_own', 'SELECT', true, true, false);


