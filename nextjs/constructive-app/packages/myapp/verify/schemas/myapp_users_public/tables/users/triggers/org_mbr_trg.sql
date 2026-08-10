-- Verify: schemas/myapp_users_public/tables/users/triggers/org_mbr_trg


SELECT assert_trigger('myapp_users_public.users'::regclass, 'org_mbr_trg', 'myapp_memberships_private.org_mbr_create'::regproc, 5);


