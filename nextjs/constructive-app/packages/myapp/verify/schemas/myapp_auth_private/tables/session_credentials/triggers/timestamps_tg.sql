-- Verify: schemas/myapp_auth_private/tables/session_credentials/triggers/timestamps_tg


SELECT assert_trigger('myapp_auth_private.session_credentials'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


