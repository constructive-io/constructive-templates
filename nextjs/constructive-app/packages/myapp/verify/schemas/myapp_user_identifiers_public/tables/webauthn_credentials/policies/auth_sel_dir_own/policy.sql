-- Verify: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/policies/auth_sel_dir_own/policy


SELECT assert_policy('myapp_user_identifiers_public.webauthn_credentials'::regclass, 'auth_sel_dir_own', 'SELECT', true, true, false);


