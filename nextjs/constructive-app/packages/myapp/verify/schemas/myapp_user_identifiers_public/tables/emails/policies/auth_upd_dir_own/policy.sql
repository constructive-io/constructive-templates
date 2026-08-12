-- Verify: schemas/myapp_user_identifiers_public/tables/emails/policies/auth_upd_dir_own/policy


SELECT assert_policy('myapp_user_identifiers_public.emails'::regclass, 'auth_upd_dir_own', 'UPDATE', true, true, false);


