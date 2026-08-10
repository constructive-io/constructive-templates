-- Verify: schemas/myapp_memberships_public/tables/org_admin_grants/triggers/org_admin_grants_insert_trg


SELECT assert_trigger('myapp_memberships_public.org_admin_grants'::regclass, 'org_admin_grants_insert_trg', 'myapp_memberships_private.org_admin_grants_apply_tg'::regproc, 7);


