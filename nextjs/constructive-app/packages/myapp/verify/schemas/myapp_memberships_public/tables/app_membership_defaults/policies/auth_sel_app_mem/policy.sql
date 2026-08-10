-- Verify: schemas/myapp_memberships_public/tables/app_membership_defaults/policies/auth_sel_app_mem/policy


SELECT assert_policy('myapp_memberships_public.app_membership_defaults'::regclass, 'auth_sel_app_mem', 'SELECT', true, true, false);


