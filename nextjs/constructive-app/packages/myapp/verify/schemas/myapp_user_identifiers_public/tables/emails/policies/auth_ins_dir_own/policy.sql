-- Verify: schemas/myapp_user_identifiers_public/tables/emails/policies/auth_ins_dir_own/policy


SELECT assert_policy('myapp_user_identifiers_public.emails'::regclass, 'auth_ins_dir_own', 'INSERT', true, false, true);


