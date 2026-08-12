-- Verify: schemas/myapp_user_identifiers_public/tables/emails/policies/auth_del_dir_own/policy


SELECT assert_policy('myapp_user_identifiers_public.emails'::regclass, 'auth_del_dir_own', 'DELETE', true, true, false);


