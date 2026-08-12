-- Verify: schemas/myapp_memberships_public/tables/org_capability_default_grants/triggers/org_capability_default_grants_insert_trg


SELECT assert_trigger('myapp_memberships_public.org_capability_default_grants'::regclass, 'org_capability_default_grants_insert_trg', 'myapp_memberships_private.org_capability_default_grants_apply_tg'::regproc, 7);


