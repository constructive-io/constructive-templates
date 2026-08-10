-- Verify: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/policies/auth_upd_dir_own/policy


SELECT assert_policy('myapp_user_identifiers_public.webauthn_credentials'::regclass, 'auth_upd_dir_own', 'UPDATE', true, true, false);


