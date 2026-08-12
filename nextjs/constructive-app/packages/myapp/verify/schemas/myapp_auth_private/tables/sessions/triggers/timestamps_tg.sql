-- Verify: schemas/myapp_auth_private/tables/sessions/triggers/timestamps_tg


SELECT assert_trigger('myapp_auth_private.sessions'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


