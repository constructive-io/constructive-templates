-- Verify: schemas/myapp_invites_public/tables/org_claimed_invites/indexes/org_claimed_invites_sender_id_idx


SELECT assert_index('myapp_invites_public.org_claimed_invites_sender_id_idx'::regclass, 'myapp_invites_public.org_claimed_invites'::regclass, false);


