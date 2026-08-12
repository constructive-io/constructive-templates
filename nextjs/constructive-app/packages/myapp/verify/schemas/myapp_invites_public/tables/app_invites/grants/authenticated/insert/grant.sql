-- Verify: schemas/myapp_invites_public/tables/app_invites/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_invites_public.app_invites'::regclass, 'authenticated', 'INSERT', ARRAY['channel', 'email', 'phone', 'expires_at', 'multiple', 'invite_limit', 'profile_id'], true);


