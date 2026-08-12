-- Verify: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/policies/auth_sel_dir_own/policy


SELECT verify_policy('auth_sel_dir_own', 'myapp_user_identifiers_public.webauthn_credentials');


