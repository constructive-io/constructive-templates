-- Verify: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/triggers/timestamps_tg


SELECT assert_trigger('myapp_memberships_public.org_capability_default_capabilities'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


