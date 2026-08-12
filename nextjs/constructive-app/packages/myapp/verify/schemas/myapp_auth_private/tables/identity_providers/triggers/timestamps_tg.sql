-- Verify: schemas/myapp_auth_private/tables/identity_providers/triggers/timestamps_tg


SELECT assert_trigger('myapp_auth_private.identity_providers'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


