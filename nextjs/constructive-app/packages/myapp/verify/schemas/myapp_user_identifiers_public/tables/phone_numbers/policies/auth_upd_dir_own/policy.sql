-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/policies/auth_upd_dir_own/policy


SELECT assert_policy('myapp_user_identifiers_public.phone_numbers'::regclass, 'auth_upd_dir_own', 'UPDATE', true, true, false);


