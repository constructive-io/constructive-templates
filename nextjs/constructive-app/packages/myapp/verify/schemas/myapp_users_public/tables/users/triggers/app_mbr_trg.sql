-- Verify: schemas/myapp_users_public/tables/users/triggers/app_mbr_trg


SELECT assert_trigger('myapp_users_public.users'::regclass, 'app_mbr_trg', 'myapp_memberships_private.app_mbr_create'::regproc, 5);


