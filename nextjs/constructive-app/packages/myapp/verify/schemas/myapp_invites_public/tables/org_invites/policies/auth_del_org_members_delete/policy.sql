-- Verify: schemas/myapp_invites_public/tables/org_invites/policies/auth_del_org_members_delete/policy


SELECT assert_policy('myapp_invites_public.org_invites'::regclass, 'auth_del_org_members_delete', 'DELETE', true, true, false);


