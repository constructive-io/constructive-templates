-- Verify: schemas/myapp_invites_public/tables/org_invites/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_invites_public.org_invites'::regclass, 'authenticated', 'INSERT', ARRAY['channel', 'email', 'phone', 'expires_at', 'multiple', 'invite_limit', 'entity_id', 'receiver_id', 'profile_id', 'is_read_only'], true);


