-- Verify: schemas/myapp_memberships_public/tables/membership_types/triggers/scope_type_sync


SELECT assert_trigger('myapp_memberships_public.membership_types'::regclass, 'scope_type_sync', 'myapp_memberships_public.tg_membership_types_scope_type_sync'::regproc, 21);


