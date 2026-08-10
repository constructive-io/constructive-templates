-- Verify: schemas/myapp_user_identifiers_public/views/user_connected_accounts/view


SELECT assert_view('myapp_user_identifiers_public.user_connected_accounts'::regclass, false, true);


