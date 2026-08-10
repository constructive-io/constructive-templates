-- Verify: schemas/myapp_memberships_public/tables/app_memberships/policies/auth_upd_app_mem/policy


SELECT assert_policy('myapp_memberships_public.app_memberships'::regclass, 'auth_upd_app_mem', 'UPDATE', true, true, false);


