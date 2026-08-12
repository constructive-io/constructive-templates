-- Verify: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/triggers/timestamps_tg


SELECT assert_trigger('myapp_user_identifiers_public.webauthn_credentials'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


