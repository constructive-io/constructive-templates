-- Verify: schemas/myapp_auth_private/tables/session_secrets/triggers/timestamps_tg


SELECT assert_trigger('myapp_auth_private.session_secrets'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


