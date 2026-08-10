-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/policies/auth_sel_dir_own/policy


SELECT assert_policy('myapp_user_identifiers_public.phone_numbers'::regclass, 'auth_sel_dir_own', 'SELECT', true, true, false);


