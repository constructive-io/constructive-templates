-- Verify: schemas/myapp_invites_public/tables/app_claimed_invites/indexes/app_claimed_invites_created_at_idx


SELECT assert_index('myapp_invites_public.app_claimed_invites_created_at_idx'::regclass, 'myapp_invites_public.app_claimed_invites'::regclass, false);


