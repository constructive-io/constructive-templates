-- Verify: schemas/myapp_invites_public/tables/app_invites/policies/auth_ins_create_invite_check/policy


SELECT assert_policy('myapp_invites_public.app_invites'::regclass, 'auth_ins_create_invite_check', 'INSERT', false, false, true);


