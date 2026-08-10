-- Verify: schemas/myapp_memberships_public/tables/membership_types/policies/auth_sel_all_all/policy


SELECT assert_policy('myapp_memberships_public.membership_types'::regclass, 'auth_sel_all_all', 'SELECT', true, true, false);


