-- Verify: schemas/myapp_invites_public/tables/app_invites/indexes/app_invites_created_at_idx


SELECT assert_index('myapp_invites_public.app_invites_created_at_idx'::regclass, 'myapp_invites_public.app_invites'::regclass, false);


