-- Verify: schemas/myapp_memberships_public/tables/org_grants/triggers/org_grants_insert_trg


SELECT assert_trigger('myapp_memberships_public.org_grants'::regclass, 'org_grants_insert_trg', 'myapp_memberships_private.org_grants_apply_tg'::regproc, 7);


