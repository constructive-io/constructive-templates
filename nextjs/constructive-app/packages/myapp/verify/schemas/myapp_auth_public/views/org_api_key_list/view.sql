-- Verify: schemas/myapp_auth_public/views/org_api_key_list/view


SELECT assert_view('myapp_auth_public.org_api_key_list'::regclass, false, true);


