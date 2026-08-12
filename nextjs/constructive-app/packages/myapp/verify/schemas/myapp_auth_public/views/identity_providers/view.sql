-- Verify: schemas/myapp_auth_public/views/identity_providers/view


SELECT assert_view('myapp_auth_public.identity_providers'::regclass, false, true);


