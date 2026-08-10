-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/policies/auth_del_dir_own/policy


SELECT assert_policy('myapp_user_identifiers_public.phone_numbers'::regclass, 'auth_del_dir_own', 'DELETE', true, true, false);


