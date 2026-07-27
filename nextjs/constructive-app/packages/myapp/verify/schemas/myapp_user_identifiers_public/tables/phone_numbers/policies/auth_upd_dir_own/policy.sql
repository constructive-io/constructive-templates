-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/policies/auth_upd_dir_own/policy


SELECT verify_policy('auth_upd_dir_own', 'myapp_user_identifiers_public.phone_numbers');


