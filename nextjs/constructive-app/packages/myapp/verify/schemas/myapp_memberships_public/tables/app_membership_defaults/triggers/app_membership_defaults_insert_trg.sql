-- Verify: schemas/myapp_memberships_public/tables/app_membership_defaults/triggers/app_membership_defaults_insert_trg


SELECT assert_trigger('myapp_memberships_public.app_membership_defaults'::regclass, 'app_membership_defaults_insert_trg', 'utils.ensure_singleton'::regproc, 7);


