-- Verify: schemas/myapp_invites_public/tables/app_invites/indexes/app_invites_sender_id_idx


SELECT assert_index('myapp_invites_public.app_invites_sender_id_idx'::regclass, 'myapp_invites_public.app_invites'::regclass, false);


