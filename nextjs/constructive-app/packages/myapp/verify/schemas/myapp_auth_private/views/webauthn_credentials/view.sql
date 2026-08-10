-- Verify: schemas/myapp_auth_private/views/webauthn_credentials/view


SELECT assert_view('myapp_auth_private.webauthn_credentials'::regclass, false, true);


