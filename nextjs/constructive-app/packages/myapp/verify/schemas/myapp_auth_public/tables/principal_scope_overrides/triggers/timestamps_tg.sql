-- Verify: schemas/myapp_auth_public/tables/principal_scope_overrides/triggers/timestamps_tg


SELECT assert_trigger('myapp_auth_public.principal_scope_overrides'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


