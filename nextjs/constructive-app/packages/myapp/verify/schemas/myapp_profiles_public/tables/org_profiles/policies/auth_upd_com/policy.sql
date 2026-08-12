-- Verify: schemas/myapp_profiles_public/tables/org_profiles/policies/auth_upd_com/policy


SELECT assert_policy('myapp_profiles_public.org_profiles'::regclass, 'auth_upd_com', 'UPDATE', true, true, false);


