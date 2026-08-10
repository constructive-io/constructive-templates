-- Verify: schemas/myapp_memberships_public/tables/app_membership_defaults/policies/auth_upd_app_mem/policy


SELECT assert_policy('myapp_memberships_public.app_membership_defaults'::regclass, 'auth_upd_app_mem', 'UPDATE', true, true, false);


