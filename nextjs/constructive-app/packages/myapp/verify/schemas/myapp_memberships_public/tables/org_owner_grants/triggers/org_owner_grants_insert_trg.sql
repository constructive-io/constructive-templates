-- Verify: schemas/myapp_memberships_public/tables/org_owner_grants/triggers/org_owner_grants_insert_trg


SELECT assert_trigger('myapp_memberships_public.org_owner_grants'::regclass, 'org_owner_grants_insert_trg', 'myapp_memberships_private.org_owner_grants_apply_tg'::regproc, 7);


