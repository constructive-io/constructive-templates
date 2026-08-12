-- Verify: schemas/myapp_auth_private/views/user_api_keys/view


SELECT assert_view('myapp_auth_private.user_api_keys'::regclass, false, true);


