-- Verify: schemas/myapp_store_public/views/app_internal_secrets/view


SELECT assert_view('myapp_store_public.app_internal_secrets'::regclass, false, true);


