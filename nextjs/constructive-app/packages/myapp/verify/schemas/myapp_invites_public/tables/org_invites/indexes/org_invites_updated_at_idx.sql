-- Verify: schemas/myapp_invites_public/tables/org_invites/indexes/org_invites_updated_at_idx


SELECT assert_index('myapp_invites_public.org_invites_updated_at_idx'::regclass, 'myapp_invites_public.org_invites'::regclass, false);


